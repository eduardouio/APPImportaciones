<?php

/* base/footer.html.twig */
class __TwigTemplate_d29a7d39ff5914ad9ba7cd1ab4004cab80c5480a6e6313fec4fa4a71995ef68c extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "</div>
</body>
<!-- NG APP cordovezApp-->
<script src=\"";
        // line 4
        echo twig_escape_filter($this->env, ($context["base_url"] ?? null), "html", null, true);
        echo "js/lib/angular.min.js\"></script>
<script src=\"";
        // line 5
        echo twig_escape_filter($this->env, ($context["base_url"] ?? null), "html", null, true);
        echo "js/app/pedidos/app.js\"></script>

</script>

<script type=\"text/javascript\">

setTimeout(function(){ reloadPage() }, 200000);

\tfunction reloadPage(argument) {
\t\tlocation.reload();
\t}
</script>
            <!-- jQuery -->
            <script src=\"";
        // line 18
        echo twig_escape_filter($this->env, ($context["base_url"] ?? null), "html", null, true);
        echo "vendor/jquery/jquery.min.js\"></script>
            <!-- Bootstrap Core JavaScript -->
            <script src=\"";
        // line 20
        echo twig_escape_filter($this->env, ($context["base_url"] ?? null), "html", null, true);
        echo "vendor/bootstrap/js/bootstrap.min.js\"></script>
            <!-- Metis Menu Plugin JavaScript -->
            <script src=\"";
        // line 22
        echo twig_escape_filter($this->env, ($context["base_url"] ?? null), "html", null, true);
        echo "vendor/metisMenu/metisMenu.min.js\"></script>
            <!-- Custom Theme JavaScript -->
            <script src=\"";
        // line 24
        echo twig_escape_filter($this->env, ($context["base_url"] ?? null), "html", null, true);
        echo "dist/js/sb-admin-2.js\"></script>
</html>
";
    }

    public function getTemplateName()
    {
        return "base/footer.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  59 => 24,  54 => 22,  49 => 20,  44 => 18,  28 => 5,  24 => 4,  19 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Twig_Source("", "base/footer.html.twig", "/var/www/html/app/src/views/base/footer.html.twig");
    }
}