#!bin/bash
var=$(echo -e "$(lsblk | grep sd)\nAbort" | dmenu -l 20)
if [ $var == "Abort" ] ;then
    echo "[*]ABORTED..."
else
  name=$(echo $var| sed "s/└─//g" | awk '{print $1}')
  size=$(echo $var| sed "s/└─//g" | awk '{print $4}')
  if [ -d "/mnt/$name" ];then
  echo "[*]Directory exists..."
  else
      sudo mkdir /mnt/$name
  fi
  if  mount | grep $name > /dev/null ;then
      echo "[*]Drive already mounted..."
  else
  sudo mount /dev/$name /mnt/$name
  fi
  echo "Total space:$size"
  echo "Location: /mnt/$name"
  if [ "$1" == "uid" ] ;then
     echo "[*]Name the user to change the directory permission.."
     read user
     sudo chown -R $user /mnt/$name
  fi
  cd /mnt/$name
fi
