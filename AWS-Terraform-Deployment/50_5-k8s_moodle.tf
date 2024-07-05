locals {
  Moodle-K8s = {
    Namespace     = "moodle"
    Config-Map    = "moodle-config"
    Storage-Class = "moodle-aws-ebs-sci-storageclass"
    PVC = {
      Moodle-Data     = "moodle-pcv-moodle-data"
      Moodledata-Data = "moodle-pvc-moodledata_data"
    }
    Deployment = {
      App-Lable-Name = "moodle"
      Name           = "moodle-deployment"
      Volumes = [
        "moodle_data",
        "moodledata_data"
      ]
      container = {
        Name = "moodle-container",

      }
    }
  }
}

/*########################################################
Kubenates Moodle Namespace Provisioner

########################################################*/
resource "kubectl_manifest" "VTC_Service-MOODLE-Namespace" {
  // nginx deployment checking
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: ${local.Moodle-K8s.Namespace}
  labels:
    name: ${local.Moodle-K8s.Namespace}
YAML
  depends_on = [
    module.VTC-Service-EKS_Cluster,
    helm_release.aws-load-balancer-controller
  ]
}


/*########################################################
Kubenates Moodle Config Map provisioner

########################################################*/
resource "kubectl_manifest" "VTC_Service-MOODLE-ConfigMap" {
  yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${local.Moodle-K8s.Config-Map}
  namespace: ${local.Moodle-K8s.Namespace}
data:
  ALLOW_EMPTY_PASSWORD: false
  MOODLE_DATABASE_NAME: ${var.Moodle-Database-Name}
  MOODLE_DATABASE_TYPE: "mysql"
  MOODLE_DATABASE_HOST: ${module.aurora_mysql_v2.cluster_endpoint}
  MOODLE_DATABASE_USER: ${var.rds-master-user}
  MOODLE_DATABASE_PASSWORD: ${var.rds-master-password}
YAML
  depends_on = [
    mysql_database.VTC_Service-Moodle,
    kubectl_manifest.VTC_Service-MOODLE-Namespace
  ]
}


/*########################################################
Kubenates Moodle StorageClass provisioner

##################################################d######*/
resource "kubectl_manifest" "VTC_Service-MOODLE-StorageClass" {
  // Claim for Moodle_data
  yaml_body = <<YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ${local.Moodle-K8s.Storage-Class}
  namespace: ${local.Moodle-K8s.Namespace}
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
YAML
  depends_on = [
    aws_efs_mount_target.VTC_Service-EFS-File_System-Mount-AZ_A,
    aws_efs_file_system.VTC_Service-EFS-File_System,
    kubectl_manifest.VTC_Service-MOODLE-Namespace
  ]
}


/*########################################################
Kubenates Moodle Persistence Volume Claim provisioner

##################################################d######*/
resource "kubectl_manifest" "VTC_Service-MOODLE-PVC-Moodle_data" {
  // Claim for Moodle_data
  yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${local.Moodle-K8s.PVC.Moodle-Data}
  namespace: ${local.Moodle-K8s.Namespace}
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ${local.Moodle-K8s.Storage-Class}
  resources:
    requests:
      storage: 5Gi
  csi:
    driver: efs.csi.aws.com
    volumeHandle: ${aws_efs_file_system.VTC_Service-EFS-File_System.id}
YAML
  depends_on = [
    kubectl_manifest.VTC_Service-MOODLE-StorageClass,
    kubectl_manifest.VTC_Service-MOODLE-Namespace
  ]
}

resource "kubectl_manifest" "VTC_Service-MOODLE-PVC-Moodledata_data" {
  // Claim for Moodledata_data
  yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${local.Moodle-K8s.PVC.Moodledata-Data}
  namespace: ${local.Moodle-K8s.Namespace}
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ${local.Moodle-K8s.Storage-Class}
  resources:
    requests:
      storage: 5Gi
  csi:
    driver: efs.csi.aws.com
    volumeHandle: ${aws_efs_file_system.VTC_Service-EFS-File_System.id}
YAML
  depends_on = [
    kubectl_manifest.VTC_Service-MOODLE-StorageClass,
    kubectl_manifest.VTC_Service-MOODLE-Namespace
  ]
}


/*########################################################
Kubenates Moodle Deployment Provisioner

########################################################*/
resource "kubectl_manifest" "VTC_Service-MOODLE-Deployment" {
  // nginx deployment checking
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${local.Moodle-K8s.Deployment.Name}
  namespace: ${local.Moodle-K8s.Namespace}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${local.Moodle-K8s.Deployment.App-Lable-Name}
  template:
    metadata:
      labels:
        app: ${local.Moodle-K8s.Deployment.App-Lable-Name}
    spec:
      volume:
        - name: ${local.Moodle-K8s.Deployment.Volumes[0]}
          persistentVolumeClaim:
            claimName: ${local.Moodle-K8s.PVC.Moodle-Data}
        - name: ${local.Moodle-K8s.Deployment.Volumes[1]}
          persistentVolumeClaim:
            claimName: ${local.Moodle-K8s.PVC.Moodledata-Data}
      containers:
        - name: ${local.Moodle-K8s.Deployment.container.Name}
          image: public.ecr.aws/bitnami/moodle:latest
          ports:
            - name: moodle-port-80
              containerPort: 8080
            - name: moodle-port-8443
              containerPort: 8443
          volumeMounts:
            - name: ${local.Moodle-K8s.Deployment.Volumes[0]}
              mountPath: /bitnami/moodle
            - name: ${local.Moodle-K8s.Deployment.Volumes[1]}
              mountPath: /bitnami/moodledata 
          envFrom:
            - configMapRef:
                name: ${local.Moodle-K8s.Config-Map}
YAML

  depends_on = [
    kubectl_manifest.VTC_Service-MOODLE-ConfigMap,
    kubectl_manifest.VTC_Service-MOODLE-Namespace,
    kubectl_manifest.VTC_Service-MOODLE-PVC-Moodle_data,
    kubectl_manifest.VTC_Service-MOODLE-PVC-Moodledata_data,
  ]
}



/*########################################################
Kubenates Moodle Provisioner

########################################################*/
resource "kubectl_manifest" "VTC_Service-MOODLE-provisioning" {
  // Moodle deployment
  for_each  = fileset("", "./EKS-Manifests/MOODLE-*.yaml")
  yaml_body = file(each.value)

  depends_on = [
    kubectl_manifest.VTC_Service-MOODLE-ConfigMap,
    kubectl_manifest.VTC_Service-MOODLE-Namespace,
    kubectl_manifest.VTC_Service-MOODLE-PVC-Moodle_data,
    kubectl_manifest.VTC_Service-MOODLE-PVC-Moodledata_data,
  ]
}
