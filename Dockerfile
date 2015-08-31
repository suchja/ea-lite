FROM suchja/wine:latest
MAINTAINER Jan Suchotzki <jan@suchotzki.de>

# get at least error information from wine
ENV WINEDEBUG -all,err+all

# unfortunately we later need to wait on wineserver. Thus a small script for waiting is supplied.
USER root
COPY waitonprocess.sh /scripts/
RUN chmod +x /scripts/waitonprocess.sh

# Install .NET Framework 4.0
USER xclient
#RUN wine wineboot --init \
#		&& /scripts/waitonprocess.sh wineserver \
#		&& winetricks --unattended dotnet40 dotnet_verifier \
#		&& /scripts/waitonprocess.sh wineserver

# Install latest Enterprise Architect Lite version
RUN mkdir /home/xclient/ea-lite \
		&& cd /home/xclient/ea-lite \
		&& curl --show-error --location "http://www.sparxsystems.com.au/bin/EALite.exe" -o ealite.msi \
		&& wine msiexec /i ealite.msi /qn \
		&& /scripts/waitonprocess.sh wineserver \
