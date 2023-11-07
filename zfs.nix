# This configuration file contains module options related to getting
# a working ZFS filesystem (with some automation and additional custom settings)

{ config, lib, pkgs, ... }:

{
  # Needed for ZFS on root
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "3e514b32";

  # Do I need to set the below to false when using legacy mountpoints? Test it...
  #systemd.services.zfs-mount.enable = false;

  # Enables some ZFS automation (e.g. snapshots, scrubs, and trims) 
  services.zfs = {
    autoScrub = {
  	  enable = true;
  	  interval = "weekly";
    };
    # Snapshots are set on /home during install
    # services.sanoid is another alternative
    autoSnapshot = { 
    	enable = true;
    	frequent = 4;
    	hourly = 24;
    	daily = 7;
    	weekly = 4;
    	monthly = 12;
    	flags = "-k -p --utc";
    };
    trim = {
  	  enable = true;
  	  interval = "weekly";
    };
    # Replicate ZFS snapshots to other systems or drives automatically
    #autoReplication {
      #enable = true;	
    #};
  };

  # ZFS latest kernel compatibility
  #boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # Change ARC size (example below sets it to 12 GB)
  # You can confirm settings have been applied using `arc_summary` or 
  # `arcstat -a -s " "`
  #boot.kernelParams = [ "zfs.zfs_arc_max=12884901888" ];
		
}
