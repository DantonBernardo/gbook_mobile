### Estrutura pasta lib
/lib
  /models        -> Modelos de dados (Book, User, etc.)
  /routes        -> Definição das rotas de navegação
  /screens       -> Telas principais do app (Login, Home, Detalhes, Formulário)
  /services      -> Comunicação com API (ex: BookService)
  /theme         -> Definições de tema, cores e estilos
  /utils         -> Funções utilitárias
  /widgets       -> Componentes reutilizáveis (botões, cards, inputs, etc.)
  main.dart      -> Arquivo inicial do projeto

### Dependências
O projeto foi configurado com as dependências essenciais para desenvolvimento Flutter, incluindo:
- `flutter/material.dart` para widgets e temas padrão;
- Sistema de rotas para navegação entre telas.

### Navegação e Rotas
O aplicativo possui um **fluxo funcional de navegação** entre pelo menos 3 telas principais:
1. **Login**: Acesso seguro ao app.
2. **Inicial (Home)**: Lista de livros disponíveis.
3. **Biblioteca geral**: Mostra de todos os livros.
3. **Detalhes do Livro**: Exibição de informações detalhadas do livro selecionado.
3. **Formulário para criar livro**: Formulário para criar novos livros.

A navegação foi implementada utilizando o **sistema de rotas do Flutter**, garantindo transições consistentes entre as telas.

### Layouts e Widgets
As telas foram construídas utilizando **widgets fundamentais** do Flutter, incluindo:
- `Scaffold` e `AppBar` para estrutura básica;
- `Column` e `Row` para organização de elementos;
- `Container` para estilização de seções;
- `Text` e `Image` para exibição de conteúdo.
- `ListView.builder` → renderização dinâmica da lista de livros.

### MicroInterações
- *GestureDetector*: interações entre botões customizavéis

### Acessibilidade (Básico)
- Contraste de cores adequado entre fundo e texto.
- Uso de Semantics em botões e imagens principais, permitindo leitura por leitores de tela.
- Tamanhos de fonte respeitando recomendações de acessibilidade.

### Formulários e Validações
- Formulário para adicionar livros com os campos: título, descrição, capa e link do PDF.
- Validação de dados para garantir preenchimento correto.
- Mensagens de erro exibidas quando necessário.

---

### Observação
Esta entrega parcial foca na estrutura inicial do projeto e layout base, sendo a base para evoluções futuras.