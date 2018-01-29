## 备份系统
It may be sensible for you to keep a copy of the entire SD card image, so you
can restore the card if you lose it or it becomes corrupt. You can do this using
the same method you'd use to write an image to a new card, but in reverse.

In Linux:

	sudo dd bs=4M if=/dev/sdb of=raspbian.img
This will create an image file on your computer which you can use to write to
another SD card, and keep exactly the same contents and settings. To restore or
clone to another card, use dd in reverse:

	sudo dd bs=4M if=raspbian.img of=/dev/sdb
These files can be very large, and compress well. To compress, you can pipe the
output of dd to gzip to get a compressed file that is significantly smaller than
the original size:

	sudo dd bs=4M if=/dev/sdb | gzip > raspbian.img.gz
To restore, pipe the output of gunzip to dd:

	gunzip --stdout raspbian.img.gz | sudo dd bs=4M of=/dev/sdb

If you are using a Mac, the commands used are almost exactly the same, but 4M in
the above examples should be replaced with 4m, with a lower case letter.
