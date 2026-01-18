---
name: recap
description: "Voir l'état complet du projet"
allowed-tools: Read(*)
---

# Récapitulatif du Projet

Affiche un récapitulatif complet de l'état du projet.

## Workflow

1. Lire `BOURBON_STATE.json`

2. Si le fichier n'existe pas :
```
📋 RÉCAP

Aucun projet en cours dans ce dossier.

Pour commencer un nouveau projet, tape : /start
```

3. Si le fichier existe, afficher :

```
════════════════════════════════════════════════════════════
📋 RÉCAPITULATIF DE TON PROJET
════════════════════════════════════════════════════════════

🎯 PROJET : [projectInfo.description]
👥 CIBLE : [projectInfo.target]
📦 TYPE : [projectInfo.type en français]
📅 CRÉÉ LE : [created en format lisible]
🕐 DERNIÈRE ACTIVITÉ : [lastActivity en relatif]

════════════════════════════════════════════════════════════

📊 PROGRESSION :

[Barre de progression visuelle basée sur completed vs total]

[████████████░░░░░░░░] 60% complété

════════════════════════════════════════════════════════════

✅ CE QUI EST FAIT :
[Liste des éléments completed en langage simple]

• Questionnaire initial ✓
• Création du projet ✓
• Page d'accueil ✓

════════════════════════════════════════════════════════════

⏳ PROCHAINES ÉTAPES :
[Liste des éléments pending]

1. Personnaliser le contenu
2. Mettre en ligne

════════════════════════════════════════════════════════════

💡 Pour continuer : dis-moi ce que tu veux faire
   ou tape /help pour voir les options
```

## Mapping des étapes en français

| Code | Français |
|------|----------|
| questions_answered | Questionnaire initial |
| project_initialized | Création du projet |
| first_page_created | Première page |
| git_initialized | Sauvegarde Git |
| content_customized | Personnalisation |
| deployed | Mise en ligne |
