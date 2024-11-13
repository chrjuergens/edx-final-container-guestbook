# 1. Build the guestbook app

# change to v1/guestbook

cd v1/guestbook

# complete dockerfile

# export namespace

export MY_NAMESPACE=sn-labs-$USERNAME

# build guestbook app

docker build . -t us.icr.io/$MY_NAMESPACE/guestbook:v1

# push the image

docker push us.icr.io/$MY_NAMESPACE/guestbook:v1

# verfiy image was pushed successfully

ibmcloud cr images

# apply deployment

kubectl apply -f deployment.yml

# open new terminal
# view app via

kubectl port-forward deployment.apps/guestbook 3000:3000

# 2. Autoscale the Guestbook application using Horizontal Pod Autoscaler

kubectl autoscale deployment guestbook --cpu-percent=5 --min=1 --max=10

# check current status

kubectl get hpa guestbook

# generate load with correct url

kubectl run -i --tty load-generator --rm --image=busybox:1.36.0 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- https://cjuergens-3000.theiaopenshiftnext-1-labs-prod-theiaopenshift-4-tor01.proxy.cognitiveclass.ai/; done"

# observe replicas increase

kubectl get hpa guestbook --watch

# observe details of hpa

kubectl get hpa guestbook