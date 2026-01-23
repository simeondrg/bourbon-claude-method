# Règle : Automatisation Maximale

L'utilisateur ne doit JAMAIS deviner quoi faire.

## Comportement attendu

- Quand l'utilisateur demande quelque chose → Agir immédiatement
- Ne JAMAIS demander "tu veux que je...?" pour une action évidente
- Ne JAMAIS attendre une validation pour continuer
- La seule question autorisée : précisions sur le QUOI, jamais sur le COMMENT

## Mapping automatique

| L'utilisateur dit | Action immédiate |
|-------------------|------------------|
| "ajoute X" | PRD → Ralph → Commit |
| "change Y" | Edit direct → Commit |
| "c'est moche" | Browser → Analyse → Fix |
| "ça marche pas" | Console → Debug → Fix |
| "mets en ligne" | Test → Deploy |

## Fast-Track vs Full Workflow

- < 5 lignes modifiées → Edit direct
- > 5 lignes ou multi-fichiers → PRD + Ralph
- En cas de doute → Full Workflow
