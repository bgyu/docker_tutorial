# Use the Red Hat Universal Base Image (UBI) 8 as the base image
FROM redhat/ubi8

# Update yum configuration and add sslverify=false
RUN sed -i '/^# *sslverify/s/^#//' /etc/yum.conf && echo "sslverify=false" >> /etc/yum.conf
    
# Add Microsoft repos
RUN curl -k https://packages.microsoft.com/config/rhel/8/prod.repo | tee /etc/yum.repos.d/mssql-release.repo
# Add mono-project repos
RUN curl -k curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/mono-centos8-stable.repo

# Update the repositories and install the latest updates
RUN dnf update -y && dnf upgrade -y

# Install required packages
RUN dnf install -y llvm-toolset lldb unixODBC-devel openssl-devel libevent-devel git cmake python39 
# Install MS packages
RUN dnf install -y msodbcsql17 dotnet-sdk-6.0
# Install mono-web
RUN dnf install -y mono-web

# Set the default command for the container
CMD ["/bin/bash"]
