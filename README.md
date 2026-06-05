# AWS Cloud Security SOC Platform

## Overview

AWS Cloud Security SOC Platform is a cloud-native Security Operations Center (SOC) project designed to demonstrate real-world security monitoring, threat detection, alerting, and cloud security auditing capabilities within Amazon Web Services (AWS).

The platform combines Infrastructure as Code (Terraform), AWS monitoring services, and Splunk Enterprise SIEM to provide centralized visibility into security events, infrastructure health, authentication activity, and cloud management operations.

The project simulates the workflow of a modern Security Operations Center by collecting logs, monitoring system performance, detecting suspicious activities, generating automated alerts, and supporting security investigations through dashboards and threat analytics.

---

## Objectives

- Deploy AWS infrastructure using Infrastructure as Code (Terraform)
- Implement centralized security monitoring using Splunk Enterprise
- Monitor infrastructure health using Amazon CloudWatch
- Generate automated security notifications using Amazon SNS
- Detect failed SSH authentication attempts and potential brute-force activity
- Perform geolocation-based analysis of suspicious login attempts
- Audit AWS management activity using AWS CloudTrail
- Create security dashboards for monitoring and investigation

---

## Solution Architecture

The solution consists of the following core components:

### AWS Infrastructure
- Amazon VPC
- Public and private networking components
- Security Groups
- Amazon EC2 instances

### Monitoring and Alerting
- Amazon CloudWatch
- CloudWatch Alarms
- Amazon SNS Notifications

### Security Monitoring
- Splunk Enterprise
- Log aggregation and analysis
- Threat detection rules
- Security dashboards

### Cloud Auditing
- AWS CloudTrail
- Amazon S3
- Amazon SQS
- AWS Add-on for Splunk

---

## Technologies Used

| Category | Technology |
|-----------|-----------|
| Cloud Platform | AWS |
| Infrastructure as Code | Terraform |
| SIEM | Splunk Enterprise |
| Monitoring | Amazon CloudWatch |
| Alerting | Amazon SNS |
| Auditing | AWS CloudTrail |
| Storage | Amazon S3 |
| Messaging | Amazon SQS |
| Operating System | Amazon Linux 2023 |
| Security Analytics | Splunk Search Processing Language (SPL) |

---

## Key Implementations

### Infrastructure as Code

The entire cloud environment was provisioned using Terraform, enabling automated, repeatable, and scalable deployments.

Infrastructure components included:

- VPC configuration
- Networking resources
- EC2 instances
- Security Groups
- CloudWatch monitoring resources
- SNS alerting infrastructure

---

### Real-Time Infrastructure Monitoring

CloudWatch was configured to monitor infrastructure performance metrics and system health.

Monitoring capabilities included:

- CPU utilization monitoring
- Memory utilization monitoring
- Resource performance tracking
- Threshold-based alert generation

---

### Automated Security Alerting

CloudWatch alarms were integrated with Amazon SNS to provide automated notifications when security or operational thresholds were exceeded.

Alerting use cases included:

- High CPU utilization
- High memory consumption
- Operational anomaly detection

---

### Security Information and Event Management (SIEM)

Splunk Enterprise was deployed as the central security monitoring platform.

Splunk capabilities implemented:

- Log collection and aggregation
- Authentication monitoring
- Security event analysis
- Threat detection
- Security dashboards
- Incident investigation support

---

### SSH Brute Force Detection

Custom detection logic was developed to identify failed SSH authentication attempts.

Detection capabilities included:

- Failed login monitoring
- Repeated authentication failure detection
- Potential brute-force attack identification
- Alert generation for suspicious activity

---

### Geolocation-Based Threat Analysis

Splunk geolocation enrichment was used to identify the geographic origin of suspicious login attempts.

Security benefits:

- Identification of attacker locations
- Regional threat visibility
- Investigation support
- Threat intelligence enrichment

---

### Security Dashboards

Custom Splunk dashboards were developed to provide visibility into security events and operational activity.

Dashboard components included:

- Failed Login Attempts by IP Address
- SSH Authentication Activity
- Attack Source Location Analysis
- Security Event Monitoring
- Infrastructure Health Monitoring

---

### Cloud Activity Auditing

AWS CloudTrail was configured to capture and audit management events across the AWS environment.

Auditing capabilities included:

- API activity monitoring
- Resource modification tracking
- Security event auditing
- Operational accountability
- Compliance visibility

---

## Security Use Cases Demonstrated

### Authentication Monitoring
Monitoring SSH authentication attempts and login failures.

### Brute Force Detection
Identifying repeated failed login attempts originating from the same source.

### Infrastructure Monitoring
Tracking system performance and resource utilization.

### Security Alert Automation
Generating automated notifications for critical events.

### Threat Intelligence Enrichment
Applying geolocation analysis to suspicious IP addresses.

### Cloud Activity Auditing
Monitoring AWS management actions through CloudTrail.

### Security Investigation
Using dashboards and log analytics to support incident response activities.

---

## Skills Demonstrated

### Cloud Security
- AWS Security Monitoring
- CloudTrail Auditing
- CloudWatch Monitoring
- Security Alerting

### SIEM Operations
- Splunk Enterprise Administration
- Security Event Analysis
- Log Management
- Threat Detection
- Security Monitoring

### Infrastructure as Code
- Terraform
- AWS Resource Provisioning
- Infrastructure Automation

### Security Operations
- Incident Detection
- Alert Investigation
- Threat Hunting
- Security Analytics

### Cloud Administration
- VPC Configuration
- EC2 Management
- IAM Integration
- Monitoring and Logging

---

## Project Outcomes

The project successfully demonstrated how AWS cloud services and Splunk SIEM can be integrated to create a functional Security Operations Center environment capable of:

- Monitoring cloud infrastructure
- Detecting suspicious authentication activity
- Generating automated alerts
- Auditing AWS management actions
- Supporting security investigations through dashboards and analytics

---

## Future Enhancements

Planned improvements include:

- AWS GuardDuty integration
- AWS Security Hub integration
- Automated incident response workflows
- Detection engineering using MITRE ATT&CK
- Advanced threat hunting use cases
- AI-powered security event summarization
- SOAR-based response automation

---

## Author

Sachin Kumar

Master of Cyber Security  
AWS Certified Solutions Architect – Associate  
Cyber Security & Cloud Security Enthusiast

GitHub Repository:
https://github.com/SachinKumar3303/aws-cloud-security-soc-platform
