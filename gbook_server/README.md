## Sistema de Gerenciamento GBook - Laravel API
API desenvolvida em Laravel para gerenciamento de livros com autenticação via JWT, controle de permissões e suporte a upload de capas/PDFs.

### Funcionalidades
  - Cadastro e autenticação de usuários com JWT
  - Middleware para controle de permissões por tipo de usuário
  - CRUD completo de livros (com soft delete)
  - Upload de capa e imagens de perfil
  - Relacionamento User → Books
  - Estrutura pronta com migrations, seeds, controllers e models

### Estrutura do DB
  - books
    -> id
    -> title
    -> description
    -> cover
    -> pdf_url
    -> created_at
    -> updated_at
    -> deleted_at
    -> user_id

  - users
    -> id
    -> type
    -> name
    -> email
    -> password
    -> profile_image
    -> created_at
    -> updated_at

### Dependências
  - Laravel Framework
  - JWT Auth→ autenticação de usuários
  - Middlewares personalizados para controle de permissões

---

## 🚀 Como rodar o projeto 🚀
1. **Clonar o repositório**
git clone https://github.com/DantonBernardo/gbook_mobile
cd gbook_server

2. **Instalar as dependências**
composer install

3. **Configurar o ambiente**
Copie o arquivo .env.example para .env e configure suas variáveis - cp .env.example.env

Edit o .env com:
  - Banco de dados (DB_DATABASE, DB_USERNAME, DB_PASSWORD) ou mantenha como sqlite
  - Chave JWT (JWT_SECRET)

4. **Gerar a chave da aplicação**
php artisan key:generate

5. **Executar migrations e seeders**
php artisan migrate --seed

6. **Gerar chave JWT**
php artisan jwt:secret

7. **Rodar o servidor**
php artisan serve

---

### Autenticação
O login retorna um JWT Token que deve ser usado no header das requisições protegidas:
  - Authorization: Bearer <token>