eval "$(cat /etc/environment | xargs printf "export %s\n")"
eval "$(AWS_DEFAULT_REGION=$APP_REGION aws ecr get-login --no-include-email)"
docker pull $APP_IMAGE_URL
(echo cd /home/ec2-user;(cat /etc/environment | xargs printf "%s ");echo $run_svc) > ./run-docker-compose && chmod +x ./run-docker-compose
