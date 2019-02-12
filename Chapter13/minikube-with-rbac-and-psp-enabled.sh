#!/bin/bash

# Enabling RBAC and PodSecurityPolicy admission control in Minikube

#I’m using Minikube version v0.19.0 to run these examples. That version doesn’t
#enable either the PodSecurityPolicy admission control plugin or RBAC authorization,
#which is required in part of the exercises. One exercise also requires authenticating
#as a different user, so you’ll also need to enable the basic authentication plugin
#where users are defined in a file.
#To run Minikube with all these plugins enabled, you may need to use this (or a similar)
#command, depending on the version you’re using:

# The following command works with minikube 0.19.0 and 0.19.1, but may not work with later versions (see command below)
minikube start --extra-config apiserver.Authentication.PasswordFile.BasicAuthFile=/etc/kubernetes/passwd --extra-config=apiserver.Authorization.Mode=RBAC --extra-config=apiserver.GenericServerRunOptions.AdmissionControl=NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,PodSecurityPolicy,ResourceQuota,DefaultTolerationSeconds


# The API server won’t start up until you create the password file you specified in the
#command line options. This is how to create the file:

# The following command might work with newer versions of minikube
#minikube start --extra-config apiserver.Authentication.PasswordFile.BasicAuthFile=/etc/kubernetes/passwd --extra-config=apiserver.Authorization.Mode=RBAC --extra-config=apiserver.Admission.PluginNames=NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,PodSecurityPolicy,ResourceQuota,DefaultTolerationSeconds

cat <<EOF | minikube ssh sudo tee /etc/kubernetes/passwd
password,alice,1000,basic-user
password,bob,2000,privileged-user
EOF

