# Déploiement de trois ressources - IoC via Bicep

La branche main centralise aujourd’hui les déclarations brutes des ressources. Nous visons à modulariser ce template d’approvisionnement pour un site standard, en tirant parti des paramètres, variables et expressions Bicep.

La progression du projet est organisée par étapes, chacune étant représentée par une branche dédiée :

- *paramsAndVars* : Intègre les paramètres et variables pour dynamiser les déclarations de ressources.
- *splitIntoMod* : Découpe le template en modules réutilisables, conformément aux bonnes pratiques Bicep pour un site classique.

> source : [learn.microsoft.com](https://learn.microsoft.com/fr-fr/training/paths/fundamentals-bicep/)


## Tâches de cette branche

Ci-dessous l'ensemble de tâches réalisées sur cette branche :

- [x] Ajouter un nouveau module et y placer les ressources App Service.
- [x] Référencez le module à partir du fichier Bicep principal.
- [x] Ajouter une sortie pour le nom d’hôte de l’application App Service et l’émettre à partir de modules et de fichiers Bicep.
- [x] Testez le déploiement pour vous assurer que le fichier Bicep est valide.

Une fois les tâches réalisées, déployer avec la commande suivante :

>```
> az deployment group create\  
>   -g yourResourceGroupName\
>   --name main\
>   --template-file main.bicep\
>   --parameters environmentType=nonprod
>```
