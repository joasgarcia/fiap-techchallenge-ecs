# Terraform para o restaurant-application

## Arquitetura
- O diagrama abaixo não contempla a outra parte da arquitetura com Api Gateway + Lambda Authorizer que está documentada em: https://github.com/joasgarcia/fiap-techchallenge-api-gateway

![ecs-arquitetura](https://github.com/joasgarcia/fiap-techchallenge-ecs/assets/6011412/e79ce68b-337d-48f3-a911-b88d739c430f)

## Como rodar
1. Insira as credenciais da conta AWS no arquivo `providers.tf`

2. Aplique a infraestrutura
```bash
terraform apply
```