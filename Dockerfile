# Use the Red Hat Universal Base Image (UBI) 8 as the base image
FROM redhat/ubi8

# Update yum configuration and add sslverify=false
RUN sed -i '/^# *sslverify/s/^#//' /etc/yum.conf && \
    echo "sslverify=false" >> /etc/yum.conf

# Update the repositories and install the latest updates
RUN yum update -y && \
    yum upgrade -y

# Install required packages
RUN yum install -y llvm-toolset lldb msodbcsql17 unixODBC-devel openssl-devel libevent-devel mono-web dotnet-sdk-6.0

# Set the default command for the container
CMD ["/bin/bash"]
