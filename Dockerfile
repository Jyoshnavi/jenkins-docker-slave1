FROM centos:7

# Step 1 - Installing Git
RUN yum install -y git

#Step 2 - Installing Python
RUN yum install -y python

#Step 3 - Installing Java 11
RUN yum install -y java-11-openjdk

#Step 4 - Install OpenSSH
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:password" | chpasswd && \
    mkdir /home/jenkins/.m2

# Copy authorized keys
COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

# #Step 4 - Install OpenSSH
# RUN yum install -y openssh-server

# #Step 5 - Enable SSH access
# RUN echo 'root:password' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN ssh-keygen -A

#Step 6 - Adding environment variables to the JAVA(optional)
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin

CMD ["/bin/bash"]
