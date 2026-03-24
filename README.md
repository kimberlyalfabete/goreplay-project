# GoReplay Live HTTP Traffic Testing on OpenStack with Performance Evaluation

## Overview

This project implements a Live HTTP Traffic Testing environment deployed on a cloud infrastructure using OpenStack. The system captures HTTP traffic from a source web application, replays it to a target web application using GoReplay, generates synthetic load using wrk, and collects system and application performance metrics for analysis.

The project was tested in two environments:

* Local deployment (macOS) for development and pipeline testing
* Cloud deployment (Ubuntu Virtual Machine on OpenStack) for performance evaluation

The primary objective of this project is to evaluate system performance under live traffic replay and synthetic load conditions in a cloud environment.

---

## OpenStack Deployment Architecture

The system is deployed on an Ubuntu instance running on OpenStack. The following components run on the cloud instance:

| Component                | Tool        |
| ------------------------ | ----------- |
| Source Web Application   | Flask       |
| Target Web Application   | Flask       |
| Traffic Capture & Replay | GoReplay    |
| Load Generator           | wrk         |
| Automation               | Jenkins     |
| Metrics Collection       | top, vmstat |

### Traffic Flow

```
Client Traffic → Source Application → GoReplay → Target Application
                                           ↑
                                         wrk
                                           ↑
                                        Jenkins
```

GoReplay captures live HTTP traffic from the source application and replays it to the target application while wrk generates additional synthetic traffic to simulate load conditions.

---

## Automated Testing Pipeline

The Jenkins pipeline automates the entire experiment process:

1. Start source application
2. Start target application
3. Start GoReplay traffic capture and replay
4. Generate synthetic traffic using wrk under different scenarios
5. Collect CPU and memory performance metrics
6. Archive benchmark results and logs

This automation allows repeatable performance testing and consistent KPI collection.

---

## Traffic Test Scenarios

The following traffic scenarios were tested:

| Scenario       | Description                            |
| -------------- | -------------------------------------- |
| Normal Load    | Standard API requests                  |
| Query Load     | API requests with different parameters |
| Slow Response  | Simulated slow server response         |
| Error Response | Simulated error conditions             |

These scenarios simulate realistic web traffic conditions and system stress situations.

---

## Performance Metrics and KPIs Collected

The system collects both **application-level performance metrics** and **system-level performance metrics**.

### Application Performance (wrk Benchmark Results)

From wrk benchmark output:

* Average Latency
* Requests per Second
* Transfer Rate (Throughput)
* Error Rate

Benchmark result files:

```
benchmark_normal_load.txt
benchmark_query_load.txt
benchmark_slow_response.txt
benchmark_error_response.txt
```

### System Performance Metrics

Collected during each test:

* CPU Usage
* Memory Usage
* System Load

System metric files:

```
system_top.txt
system_vmstat.txt
```

### Application and Replay Logs

```
source.log
target.log
gor.log
```

These logs were used to verify traffic replay behaviour and application responses.

---

## Repository Structure

```
goreplay-project/
├── source-app/
├── target-app/
├── scripts/
├── results/
├── Jenkinsfile
└── README.md
```

---

## Running the System on OpenStack

On the Ubuntu OpenStack instance, install dependencies:

```
sudo apt update
sudo apt install python3-flask
sudo apt install wrk
```

Install GoReplay:

```
wget https://github.com/buger/goreplay/releases/download/v1.3.3/gor_1.3.3_x64.tar.gz
tar -xvzf gor_1.3.3_x64.tar.gz
sudo mv gor /usr/local/bin/
```

Then run the automated pipeline using Jenkins or run scripts manually from the project directory.

---

## Local Development Environment

A local deployment was used during development to:

* Test the Jenkins pipeline
* Debug scripts
* Validate traffic replay behaviour
* Verify benchmark result collection

The local environment ensured the system was functioning correctly before deploying to the OpenStack cloud environment.

---

## Project Objective

The objective of this project is to deploy a live HTTP traffic testing environment in a cloud infrastructure and evaluate system performance under replayed and synthetic traffic conditions. The collected benchmark results and system performance metrics are used to analyse system behaviour, performance bottlenecks, and reliability under different traffic scenarios.
