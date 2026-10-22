<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    // Codifica texto não confiável antes de colocá-lo entre tags HTML (prevenção de XSS).
    private String escaparHtml(String valor) {
        if (valor == null) return "";
        return valor.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>
<%
    // request: lê o método HTTP e os parâmetros enviados pelo formulário.
    request.setCharacterEncoding("UTF-8");
    boolean metodoPost = "POST".equalsIgnoreCase(request.getMethod());
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String turma = request.getParameter("turma");
    nome = nome == null ? "" : nome.trim();
    email = email == null ? "" : email.trim();
    turma = turma == null ? "" : turma.trim();

    // A lista permitida impede que o cliente envie um código de turma inventado.
    String nomeTurma = "";
    if ("web".equals(turma)) nomeTurma = "Programação para Web";
    else if ("bd".equals(turma)) nomeTurma = "Banco de Dados";
    else if ("es".equals(turma)) nomeTurma = "Engenharia de Software";

    boolean valido = metodoPost
        && !nome.isEmpty() && nome.length() <= 120
        && email.length() <= 254
        && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")
        && !nomeTurma.isEmpty();

    // session: mantém o último nome cadastrado nas próximas requisições da sessão.
    if (valido) session.setAttribute("ultimoCadastro", nome);
    // response: orienta o navegador a não armazenar esta página com dados pessoais em cache.
    response.setHeader("Cache-Control", "no-store");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Resultado do Cadastro — UNICEPLAC</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <main class="container py-5">
    <h1 class="h2 mb-4">Resultado do Cadastro</h1>
    <% if (valido) { %>
      <div class="alert alert-success" role="status">
        <h2 class="h4">Cadastro realizado com sucesso</h2>
        <hr>
        <%-- A expressão JSP escreve no out (JspWriter); escaparHtml protege a saída HTML. --%>
        <p><strong>Nome:</strong> <%= escaparHtml(nome) %></p>
        <p><strong>E-mail:</strong> <%= escaparHtml(email) %></p>
        <p><strong>Turma:</strong> <%= escaparHtml(nomeTurma) %></p>
      </div>
      <p class="text-secondary">Este exercício mantém apenas o último nome na sessão; não grava dados em banco de dados.</p>
      <a href="turmas.jsp" class="btn btn-success">Ver turmas</a>
    <% } else { %>
      <div class="alert alert-danger" role="alert">
        <h2 class="h4">Não foi possível cadastrar</h2>
        <p class="mb-0">Envie o formulário por POST e preencha nome, e-mail e uma turma válida.</p>
      </div>
    <% } %>
    <a href="portal-bootstrap.html" class="btn btn-outline-secondary ms-2">Voltar ao portal</a>
  </main>
</body>
</html>
