<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
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
    // O array representa as turmas apenas para a demonstração; não há banco de dados.
    String[][] turmas = {
        { "Programação para Web", "ENSOF4AN1", "60h", "Reinaldo Vieira" },
        { "Banco de Dados", "ENSOF4BD1", "80h", "Carlos Souza" },
        { "Engenharia de Software", "ENSOF4ES1", "80h", "Ana Lima" }
    };
    // session: recupera o nome salvo em processar.jsp.
    String ultimoCadastro = (String) session.getAttribute("ultimoCadastro");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Turmas — UNICEPLAC</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <main class="container py-4">
    <h1 class="h2 mb-4">Turmas do 4º Período</h1>
    <div class="table-responsive">
      <table class="table table-bordered table-hover align-middle">
        <caption>Disciplinas, códigos, cargas horárias e professores</caption>
        <thead class="table-dark">
          <tr><th scope="col">#</th><th scope="col">Disciplina</th><th scope="col">Código</th><th scope="col">Carga</th><th scope="col">Professor</th></tr>
        </thead>
        <tbody>
          <%-- O scriptlet gera uma linha da tabela para cada turma. --%>
          <% for (int i = 0; i < turmas.length; i++) { %>
          <tr>
            <th scope="row"><%= i + 1 %></th>
            <td><%= escaparHtml(turmas[i][0]) %></td>
            <td><%= escaparHtml(turmas[i][1]) %></td>
            <td><%= escaparHtml(turmas[i][2]) %></td>
            <td><%= escaparHtml(turmas[i][3]) %></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
    <% if (ultimoCadastro != null) { %>
      <div class="alert alert-info">Último cadastro desta sessão: <strong><%= escaparHtml(ultimoCadastro) %></strong></div>
    <% } %>
    <a href="portal-bootstrap.html" class="btn btn-outline-success">Voltar ao portal</a>
  </main>
</body>
</html>
