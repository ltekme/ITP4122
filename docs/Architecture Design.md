# Architecture Design

## Network

Interms of the ip addressing of the VPC, each subnet contins 250 usable IP address.

- Public Subnets
  - used to servers that require direct online access
  - Attached to an internet gateway for direct internet access
  - CIDR
    - 10.0.0.0/24 us-east-1a
    - 10.0.1.0/24 us-east-1b
- Private Subnets
  - used for internal servers e.g. K8s worker nodes
  - No direct ip address assigned to each machines, access to internet using NAT gatway
  - CIDR
    - 10.0.2.0/24 us-east-1a
    - 10.0.3.0/24 us-east-1b
- Intra subnets
  - used for internal only services, e.g. K8s master nodes.
  - no access to internet in any form, only able to connect to local subnets
  - CIDR
    - 10.0.5.0/24 us-east-1a
    - 10.0.6.0/24 us-east-1b

Each subnet should have it's own route table

Site to Site vpn will be used for connecting between AWS and On-premas network.
