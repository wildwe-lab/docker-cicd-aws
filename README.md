# Automated Docker Deployment with GitHub Actions & AWS ECS Fargate

## Project Overview

This project demonstrates an end-to-end DevOps CI/CD workflow for containerizing and automatically deploying a web application to AWS.

The application is packaged using Docker, stored in Amazon ECR, and deployed as a container using Amazon ECS Fargate. AWS infrastructure is provisioned using Terraform, while GitHub Actions automates the build and deployment process whenever changes are pushed to the `main` branch.

GitHub Actions authenticates securely with AWS using OpenID Connect (OIDC), avoiding the use of long-lived AWS access keys.

---

## Architecture

```text
Developer
    |
    | git push
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    | OIDC Authentication
    v
AWS IAM
    |
    v
Docker Build
    |
    v
Amazon ECR
    |
    | Pull Docker Image
    v
Amazon ECS
    |
    v
AWS Fargate
    |
    v
Web Application
