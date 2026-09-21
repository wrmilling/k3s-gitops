# `media` Namespace

## calibre

* [calibre/calibre.yaml](calibre/calibre.yaml) - HelmRelease for Calibre
* [calibre/pvc.yaml](calibre/pvc.yaml) - PVC for Calibre library data
* [calibre/gateway-policies.yaml](calibre/gateway-policies.yaml) - BackendTrafficPolicy raising the upload body-size limit

## copyparty

* [copyparty/copyparty.yaml](copyparty/copyparty.yaml) - HelmRelease for Copyparty
* [copyparty/pvc.yaml](copyparty/pvc.yaml) - PVC for Copyparty storage
* [copyparty/gateway-policies.yaml](copyparty/gateway-policies.yaml) - SecurityPolicy bypassing Authelia

## lidarr

* [lidarr/lidarr.yaml](lidarr/lidarr.yaml) - HelmRelease for Lidarr
* [lidarr/pvc.yaml](lidarr/pvc.yaml) - PVC for Lidarr
* [lidarr/volsync.yaml](lidarr/volsync.yaml) - Volsync backup for Lidarr PVC

## nzbget

* [nzbget/nzbget.yaml](nzbget/nzbget.yaml) - HelmRelease for NZBGet
* [nzbget/pvc.yaml](nzbget/pvc.yaml) - PVC for NZBGet
* [nzbget/volsync.yaml](nzbget/volsync.yaml) - Volsync backup for NZBGet PVC
* [nzbget/gateway-policies.yaml](nzbget/gateway-policies.yaml) - BackendTrafficPolicy raising the upload body-size limit

## plex

* [plex/plex.yaml](plex/plex.yaml) - HelmRelease for Plex
* [plex/pvc.yaml](plex/pvc.yaml) - PVC for Plex
* [plex/volsync.yaml](plex/volsync.yaml) - Volsync backup for Plex PVC
* [plex/gateway-policies.yaml](plex/gateway-policies.yaml) - SecurityPolicy bypassing Authelia

## prowlarr

* [prowlarr/prowlarr.yaml](prowlarr/prowlarr.yaml) - HelmRelease for Prowlarr
* [prowlarr/pvc.yaml](prowlarr/pvc.yaml) - PVC for Prowlarr
* [prowlarr/volsync.yaml](prowlarr/volsync.yaml) - Volsync backup for Prowlarr PVC

## qbittorrent

* [qbittorrent/qbittorrent.yaml](qbittorrent/qbittorrent.yaml) - HelmRelease for qBittorrent
* [qbittorrent/pvc.yaml](qbittorrent/pvc.yaml) - PVC for qBittorrent
* [qbittorrent/volsync.yaml](qbittorrent/volsync.yaml) - Volsync backup for qBittorrent PVC

## radarr

* [radarr/radarr.yaml](radarr/radarr.yaml) - HelmRelease for Radarr
* [radarr/pvc.yaml](radarr/pvc.yaml) - PVC for Radarr
* [radarr/volsync.yaml](radarr/volsync.yaml) - Volsync backup for Radarr PVC

## recyclarr

* [recyclarr/configmap.yaml](recyclarr/configmap.yaml) - ConfigMap for Recyclarr settings
* [recyclarr/recyclarr.yaml](recyclarr/recyclarr.yaml) - HelmRelease for Recyclarr
* [recyclarr/pvc.yaml](recyclarr/pvc.yaml) - PVC for Recyclarr
* [recyclarr/volsync.yaml](recyclarr/volsync.yaml) - Volsync backup for Recyclarr PVC

## seerr

* [seerr/seerr.yaml](seerr/seerr.yaml) - HelmRelease for Seerr (Overseerr's successor)
* [seerr/pvc.yaml](seerr/pvc.yaml) - PVC for Seerr
* [seerr/volsync.yaml](seerr/volsync.yaml) - Volsync backup for Seerr PVC
* [seerr/gateway-policies.yaml](seerr/gateway-policies.yaml) - SecurityPolicy bypassing Authelia

## seerr-kids

* [seerr-kids/seerr.yaml](seerr-kids/seerr.yaml) - HelmRelease for Seerr, kids-only request instance
* [seerr-kids/pvc.yaml](seerr-kids/pvc.yaml) - PVC for Seerr (kids)
* [seerr-kids/volsync.yaml](seerr-kids/volsync.yaml) - Volsync backup for Seerr (kids) PVC
* [seerr-kids/gateway-policies.yaml](seerr-kids/gateway-policies.yaml) - SecurityPolicy bypassing Authelia

## shelfmark

* [shelfmark/shelfmark.yaml](shelfmark/shelfmark.yaml) - HelmRelease for Shelfmark
* [shelfmark/pvc.yaml](shelfmark/pvc.yaml) - PVC for Shelfmark
* [shelfmark/volsync.yaml](shelfmark/volsync.yaml) - Volsync backup for Shelfmark PVC

## sonarr

* [sonarr/sonarr-anime.yaml](sonarr/sonarr-anime.yaml) - HelmRelease for Sonarr (anime)
* [sonarr/sonarr-series.yaml](sonarr/sonarr-series.yaml) - HelmRelease for Sonarr (series)
* [sonarr/pvc.yaml](sonarr/pvc.yaml) - PVC for Sonarr
* [sonarr/volsync.yaml](sonarr/volsync.yaml) - Volsync backup for Sonarr PVC
