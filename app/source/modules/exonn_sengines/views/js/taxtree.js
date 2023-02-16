//var tree = getTree();


function makeIcon(a, b, e) {
  a = new Image(a, b);
  a.src = e;
  return a
}
var icons = {expand:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/expand.png"),expand_hover:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/expand_hover.png"),collapse:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/collapse.png"),collapse_hover:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/collapse_hover.png"),complete:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/complete.png"),expandall:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/expandall.png"),
  expandall_hover:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/expandall_hover.png"),jump:makeIcon(12, 12, "../modules/exonn_sengines/views/css/bg/goto.png")};
function setClass(a, b) {
  document.all ? a.className = b : a.setAttribute("class", b)
}
function relativePath(a, b) {
  for (var e = 0; ;) {
    var c;
    a:{
      for (c = e; c < a.length; c++)if (0 <= ":><|/;{}=+_*^%$#@!`~".indexOf(a.charAt(c)))for (var f = c + 1; f < a.length; f++)if (" " !== a.charAt(c)) {
        c = f;
        break a
      }
      c = void 0
    }
    if (void 0 === c || c > b.length || a.substr(0, c) != b.substr(0, c))return 0 < e ? ("\u2026 \u203a " + b.substr(e)).replace(/>/g, "\u203a") : b.replace(/>/g, "\u203a");
    e = c
  }
}
function makeShortNames(a, b, e, c) {
  var f;
  if (0 === b.n.indexOf(a)) {
    for (a = a.length; a < b.n.length && " " === b.n.charAt(a);)a++;
    if (a < b.n.length && 0 <= ":><|/;{}=+_*^%$#@!`~".indexOf(b.n.charAt(a))) {
      for (a++; a < b.n.length && " " === b.n.charAt(a);)a++;
      a = b.n.substr(a, b.n.length - a)
    } else a = b.n
  } else a = b.n;
  f = a;
  a = b;
  var g = f;
  f = c;
  a.s = g;
  a.l = a.i ? a.i + " " : "";
  a.l += g.toLowerCase();
  if (void 0 != a.y) {
    for (var d,g = 0; g < a.y.length; g++) {
      if (f && "en-US" !== f && a.y[g].l === f && (a.s = a.y[g].s,a.y[g].m))for (var h = 0; h < a.y[g].m.length; h++)if ("STANDALONE" ===
              a.y[g].m[h].n) {
        d = a.y[g].s;
        break
      }
      h = a.y[g].s.toLowerCase();
      -1 === a.l.indexOf(h) && (a.l += " " + h)
    }
    void 0 !== d && "en-US" !== f && (a.s = d)
  }
  a.definition && (d = a.definition,d.def ? (a.l += " " + d.def.toLowerCase(),a.l += d.sa ? " " + d.sa.toLowerCase() : "",a.l += d.may ? " " + d.may.toLowerCase() : "",a.l += d.not ? " " + d.not.toLowerCase() : "",a.l += d.cmt ? " " + d.cmt.toLowerCase() : "") : d.fulldef && (a.l += " " + d.fulldef.toLowerCase()));
  if (void 0 != b.c)for (d = 0; d < b.c.length; d++)makeShortNames(b.n, b.c[d], e, c);
  if (void 0 != b.a)for (d = 0; d < b.a.length; d++)b.a[d].s =
          relativePath(b.n, b.a[d].n);
  if (void 0 != b.r)for (d = 0; d < b.r.length; d++)b.r[d].s = relativePath(b.n, b.r[d].n)
}
function addExpandableChild(a, b, e, c, f) {
  var g = document.createElement("div");
  c = void 0 === c || !c.searchother && (!0 === b.altchild || !0 === b.alt) ? void 0 : c.ismatch(b);
  var d = layoutNode(b, e, f, c);
  g.appendChild(d);
  a.hitList = [g];
  if (!0 === b.altchild || !0 === b.alt) {
    var h = document.createElement("img");
    h.src = icons.jump.src;
    h.style.marginLeft = "4px";
    h.width = 12;
    h.height = 12;
    h.style.cursor = "pointer";
    h.onclick = function() {
      var a = f,c = matchNode(b.n),d = document.getElementById(a.rootid);
      clearResults(d);
      makeTable(d, a.tree.t, void 0, c,
              a)
    };
    g.appendChild(h)
  } else!0 !== b.altchild && !0 !== b.alt && !(void 0 === b.c && void 0 === b.a && void 0 === b.r) && (h = document.createElement("img"),h.style.marginLeft = "4px",h.width = 12,h.height = 12,h.style.cursor = "pointer",h.onmouseover = function() {
    h.src = icons.expand_hover.src
  },h.onmouseout = function() {
    h.src = icons.expand.src
  },h.onclick = function() {
    makeTable(a, b, e, void 0, f)
  },h.onmouseout(),g.appendChild(h));
  a.appendChild(g);
  return void 0 !== c
}
function highlightingSpan(a, b, e, c) {
  var f = document.createElement("span");
  f.appendChild(b);
  f.style.cursor = "pointer";
  var g = c.makenode(f, a);
  g.highlight = function() {
    g.style.background = "#FFFFAA";
    void 0 != e && e.highlight()
  };
  g.unhighlight = function() {
    g.style.background = "";
    void 0 != e && e.unhighlight()
  };
  return g
}
function appendSearched(a, b, e) {
  var c = void 0 === e ? -1 : b.toLowerCase().lastIndexOf(e);
  if (-1 == c)a.appendChild(document.createTextNode(b)); else {
    var f = document.createElement("span");
    f.appendChild(document.createTextNode(b.substr(0, c)));
    var g = document.createElement("span");
    g.appendChild(document.createTextNode(b.substr(c, e.length)));
    var d = document.createElement("span");
    d.appendChild(document.createTextNode(b.substr(c + e.length, b.length - (c + e.length))));
    g.style.background = "#FFE700";
    a.appendChild(f);
    a.appendChild(g);
    a.appendChild(d)
  }
}
function layoutNode(a, b, e, c) {
  var f = document.createElement("span"),g = document.createElement("span");
  if (!0 === a.altchild) {
    c = document.createElement("span");
    setClass(c, "rel");
    c.innerHTML = "(secondary children)&nbsp;";
    var d = document.createElement("span");
    d.appendChild(document.createTextNode(a.s));
    f.appendChild(c);
    g.appendChild(d);
    f.appendChild(highlightingSpan(a, g, b, e))
  } else if (!0 === a.alt)c = document.createElement("span"),setClass(c, "rel"),d = a.i,d = "accessory_of" === d ? "(accessories)" : "see_also" === d ? '("see also" from)' :
          "\u2190 " + d,c.innerHTML = d + "&nbsp;",d = document.createElement("span"),d.appendChild(document.createTextNode(a.s)),f.appendChild(c),g.appendChild(d),f.appendChild(highlightingSpan(a, g, b, e)); else if (appendSearched(g, a.s, c),f.appendChild(highlightingSpan(a, g, b, e)),void 0 !== a.y && void 0 !== c) {
    b = document.createElement("span");
    setClass(b, "tree_synonyms");
    e = !0;
    for (g = 0; g < a.y.length; g++)a.y[g].s != a.s && (e ? b.appendChild(document.createTextNode(" (")) : b.appendChild(document.createTextNode("; ")),appendSearched(b,
            a.y[g].s, c),e = !1);
    e || (b.appendChild(document.createTextNode(")")),f.appendChild(b))
  }
  return f
}
function matchNode(a) {
  function b(b) {
    if (b.n === a)return b.s
  }

  function e(a) {
    if (b(a))return!0;
    if (void 0 !== a.c)for (var f = 0; f < a.c.length; f++)if (e(a.c[f]))return!0;
    return!1
  }

  return{ismatch:b,searchother:!1,hasmatch:e}
}
function matchSubstring(a) {
  function b(b) {
    if (void 0 === b.l)alert(b.n); else if (b = b.l.lastIndexOf(a),-1 != b)return a
  }

  function e(b) {
    if (void 0 != b.has) {
      if (b.has.b && 0 <= b.has.v.indexOf(a))return!0;
      if (!b.has.b && 0 <= a.indexOf(b.has.v))return!1
    }
    c.c++;
    if (0 <= b.l.indexOf(a))return b.has = {v:a,b:!0},!0;
    if (void 0 != b.c)for (var g = 0; g < b.c.length; g++)if (e(b.c[g]))return b.has = {v:a,b:!0},!0;
    b.has = {v:a,b:!1};
    return!1
  }

  var c = {c:0};
  return{ismatch:b,searchother:!1,hasmatch:e,calls:c}
}
function childmatch(a, b) {
  if (void 0 != a.c)for (var e = 0; e < a.c.length; e++)if (b.hasmatch(a.c[e]))return!0;
  return!1
}
function makeTable(a, b, e, c, f) {
  function g(c, d) {
    void 0 === d && !0 === f.advanced && (c.expandall = !0);
    c.style.marginLeft = 4;
    c.onmouseover = function() {
      c.mouseon = !0;
      c.src = c.expandall ? icons.expandall_hover.src : icons.collapse_hover.src
    };
    c.onmouseout = function() {
      c.mouseon = !1;
      c.src = c.expandall ? icons.expandall.src : icons.collapse.src
    };
    c.onmouseout();
    c.onclick = function() {
      for (var d = 0; d < a.hitList.length; d++)a.removeChild(a.hitList[d]);
      a.hitList = [];
      c.expandall ? makeTable(a, b, e, everythingSearch, f) : addExpandableChild(a, b, e,
              void 0, f)
    };
    window.setTimeout(function() {
      if (c.expandall)if (c.expandall = void 0,c.mouseon)c.onmouseover(); else c.onmouseout()
    }, 500)
  }

  function d() {
    for (var a = 0; a < r.length; a++)r[a].style.display = "",r[a].style.borderTop = "1px solid #DDDDF7";
    0 < a && (r[0].style.borderTop = "0");
    void 0 != u && (u.style.display = "none");
    g(p, {})
  }

  if (void 0 != a.hitList)for (var h = 0; h < a.hitList.length; h++)a.removeChild(a.hitList[h]);
  a.hitList = [];
  if (void 0 === b.c && void 0 === b.a && void 0 === b.r || void 0 != c && !childmatch(b, c))return addExpandableChild(a,
          b, e, c, f);
  var t = document.createElement("table");
  setClass(t, "expanded");
  var q = document.createElement("tbody");
  t.appendChild(q);
  var k = document.createElement("tr");
  setClass(k, "childtitle");
  var l = document.createElement("td");
  q.appendChild(k);
  l.style.verticalAlign = "top";
  l.style.border = "0";
  l.style.padding = "0";
  var q = void 0 !== e,n = void 0 === c ? void 0 : c.ismatch(b);
  void 0 !== n && (q = !0);
  var s = layoutNode(b, e, f, n);
  l.appendChild(s);
  var p = document.createElement("img");
  p.width = 12;
  p.height = 12;
  p.style.marginLeft = "4px";
  p.style.cursor =
          "pointer";
  l.appendChild(p);
  k.appendChild(l);
  l = [];
  void 0 !== b.c && (l = l.concat(b.c));
  if (void 0 !== b.a) {
    n = b.a.slice();
    for (h = 0; h < n.length; h++)n[h].altchild = !0;
    l = l.concat(n)
  }
  if (void 0 !== b.r) {
    n = b.r.slice();
    for (h = 0; h < n.length; h++)n[h].alt = !0;
    l = l.concat(n)
  }
  l.sort(function(a, b) {
    if (!0 === a.alt)return!0 === b.alt ? a.n < b.n ? -1 : a.n === b.n ? 0 : 1 : 1;
    if (!0 == a.altchild)return!0 === b.alt ? -1 : !0 === b.altchild ? a.n < b.n ? -1 : a.n === b.n ? 0 : 1 : 1;
    if (!0 === b.alt || !0 === b.altchild)return-1;
    if ("[" === a.s.charAt(0)) {
      if ("[" !== b.s.charAt(0))return 1
    } else if ("[" ===
            b.s.charAt(0))return-1;
    return a.s < b.s ? -1 : a.s === b.s ? 0 : 1
  });
  var w = void 0 != c && void 0 != c.context ? c.context : 0,r = [],m = document.createElement("td");
  setClass(m, "childrenholder");
  k.appendChild(m);
  k = document.createElement("table");
  setClass(k, "children");
  m.appendChild(k);
  var v = document.createElement("tbody");
  k.appendChild(v);
  for (var x = !0,h = 0; h < l.length; h++)k = document.createElement("tr"),v.appendChild(k),setClass(k, "childrow"),!0 === l[h].altchild ? k.style.background = "#F7F7FF" : !0 === l[h].alt && (k.style.background =
          "#FFF7F7"),m = document.createElement("td"),setClass(m, "childspacer"),k.appendChild(m),m = document.createElement("td"),setClass(m, "childvalue"),k.appendChild(m),n = !1,n = !0 !== l[h].altchild && !0 !== l[h].alt && void 0 !== l[h].c && void 0 !== c ? makeTable(m, l[h], s, c, f) : addExpandableChild(m, l[h], s, c, f),q = q || n,!n && void 0 != c && 0 >= w ? (k.style.display = "none",r.push(k)) : (w--,x ? (k.style.borderTop = "0",x = !1) : k.style.borderTop = "1px solid #DDDDF7");
  var u = void 0;
  0 === r.length ? g(p, c) : (p.src = icons.complete.src,p.onclick = d,u = k = document.createElement("tr"),
          v.appendChild(k),m = document.createElement("td"),setClass(m, "childspacer"),k.appendChild(m),m = document.createElement("td"),setClass(m, "elipsis"),k.appendChild(m),s = document.createElement("span"),m.appendChild(s),s.innerHTML = "...",m.cursor = "pointer",m.onclick = d);
  a.appendChild(t);
  a.hitList = [t];
  return q
}
function alwaysMatch() {
  return"__expand all__"
}
var everythingSearch = {ismatch:alwaysMatch,searchother:!0,hasmatch:function() {
  return!0
}};
function expandAll(a) {
  makeTable(document.getElementById(a.rootid), a.tree.t, void 0, everythingSearch, a)
}
function clearResults(a) {
  for (var b = 0; b < a.hitList.length; b++)a.removeChild(a.hitList[b]);
  a.hitList = []
}
function searchKeypress(a, b) {
  return function() {
    var e = document.getElementById(a),c;
    c = e.value;
    for (var f = 0,g = 0; g < c.length; g++)var d = c.charCodeAt(g),f = 13312 <= d && 40959 >= d || 63744 <= d && 64255 >= d ? f + 3 : 12448 <= d && 12543 >= d || 12352 <= d && 12447 >= d ? f + 2 : f + 1;
    c = f;
    3 <= c ? (c = b,e = matchSubstring(e.value.toLowerCase()),f = document.getElementById(c.rootid),clearResults(f),makeTable(f, c.tree.t, void 0, e, c)) : (e = document.getElementById(b.rootid),clearResults(e),addExpandableChild(e, b.tree.t, void 0, void 0, b))
  }
}



function makenode(a, b) {
  a.onclick = function() {
    document.getElementById("sel_csv").innerHTML = '"' + b.n + '"';
    var a = b.n.replace(/&/g, "&amp;amp;"),a = a.replace(/>/g, "&amp;gt;");
    a = b.n;
    document.getElementById("sel_xml").innerHTML = a
  };
  return a
}
var ic_config = {makenode:makenode,rootid:"itemclass_searchable_root",tree:tree,advanced:!1};
function tree_initialize() {
  makeShortNames("", tree.t, tree.s);
  makeTable(document.getElementById("itemclass_searchable_root"), tree.t, void 0, void 0, ic_config);
  document.getElementById("typotree").onkeyup = searchKeypress("typotree", ic_config)
}
window.searchKeypress = searchKeypress;
window.expandAll = expandAll;
window.tree = tree;
window.tree_initialize = tree_initialize;
window.ic_config = ic_config;