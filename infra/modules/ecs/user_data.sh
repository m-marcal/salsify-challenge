#!/bin/bash

###############################
## Bootstrap required values for EC2 machines to be used
## by Elastic Cluster Service
################################
echo ECS_CLUSTER='${ecs_cluster_name}' >> /etc/ecs/ecs.config
echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;