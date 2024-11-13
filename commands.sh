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