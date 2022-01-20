# SSH login Doesnt work with 18.04 and 20.04
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server vim nano curl iputils-ping
RUN mkdir /var/run/sshd

RUN mkdir /var/test
RUN mkdir /var/test/demofiles
RUN echo "Me gusta el vino" > /var/test/demofiles/vino.txt 
RUN echo "La cocacola no es sana" > /var/test/demofiles/refresco.txt 
RUN echo "Me hago una copia de seguridad" > /var/test/demofiles/refresco.bck 

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:ansiblepass" | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
