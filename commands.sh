aws eks describe-cluster \
  --name <cluster-name> \
  --query "cluster.identity.oidc.issuer" \
  --output text  (for oidc provider)

  eksctl utils associate-iam-oidc-provider \
  --cluster <cluster-name> \
  --approve   (if oicd not associated)


  curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
  (for iam)

  aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json   (create police)

  eksctl create iamserviceaccount \
  --cluster <cluster-name> \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve  (roles + service account)


  sudo yum install -y curl
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
(install helms)


helm repo add eks https://aws.github.io/eks-charts
helm repo update  (install controler via helms)

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=<cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller


  kubectl get pods -n kube-system  (forvarification)

  helm install my-nginx ./generic-app  (final command)
   
   kubectl get ingress