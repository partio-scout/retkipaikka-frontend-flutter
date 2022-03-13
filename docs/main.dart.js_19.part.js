self.$__dart_deferred_initializers__=self.$__dart_deferred_initializers__||Object.create(null)
$__dart_deferred_initializers__.current=function(a,b,c,$){var B={
aM4(d,e,f){return new B.adk(D.W6,!0,f,!1,C.bD,C.bD,e,d)},
adk:function adk(d,e,f,g,h,i,j,k){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i
_.r=j
_.x=k},
b5y(d,e,f,g,h,i,j){var x,w,v,u,t,s,r,q,p,o,n
if(d!=null){v=d.length
v=v===0||v>2083||C.b.bp(d,"mailto:")}else v=!0
if(v)return!1
x=null
w=null
v=y.d
u=A.a(d.split("://"),v)
if(u.length>1){if(!C.c.C(h,B.AG(u)))return!1}else if(i)return!1
u=A.a(C.c.bV(u,"://").split("#"),v)
d=B.AG(u)
t=C.c.bV(u,"#")
if(t.length!==0){s=A.bf("\\s",!0)
s=s.b.test(t)}else s=!1
if(s)return!1
u=A.a(d.split("?"),v)
d=B.AG(u)
r=C.c.bV(u,"?")
if(r.length!==0){s=A.bf("\\s",!0)
s=s.b.test(r)}else s=!1
if(s)return!1
u=A.a(d.split("/"),v)
d=B.AG(u)
q=C.c.bV(u,"/")
if(q.length!==0){s=A.bf("\\s",!0)
s=s.b.test(q)}else s=!1
if(s)return!1
u=A.a(d.split("@"),v)
if(u.length>1){p=B.AG(u)
s=p==null?null:C.b.C(p,":")
if(s===!0){s=B.AG(A.a(p.split(":"),v))
s.toString
o=A.bf("^\\S+$",!0)
if(!o.b.test(s))return!1
o=A.bf("^\\S*$",!0)
if(!o.b.test(s))return!1}}u=A.a(C.c.bV(u,"@").split(":"),v)
v=B.AG(u)
v.toString
if(u.length!==0){w=C.c.bV(u,":")
try{x=A.dS(w,10)}catch(n){return!1}s=A.bf("^[0-9]+$",!0)
o=w
if(!s.b.test(o)||x<=0||x>65535)return!1}if(!B.aIW(v,null)&&!B.b5u(v,!1,!0)&&v!=="localhost")return!1
return!0},
aIW(d,e){var x,w
if(e==null)return B.aIW(d,4)||B.aIW(d,6)
else if(e===4){x=$.aTu().b
if(!x.test(d))return!1
w=A.a(d.split("."),y.d)
C.c.dJ(w,new B.aEG())
return A.dS(w[3],null)<=255}if(e===6){x=$.aTv().b
x=x.test(d)}else x=!1
return x},
b5u(d,e,f){var x,w,v,u,t=A.a(d.split("."),y.d),s=t.pop()
if(t.length!==0){x=A.bf("^[a-z]{2,}$",!0)
x=!x.b.test(s)}else x=!0
if(x)return!1
for(x=t.length,w=0;w<t.length;t.length===x||(0,A.A)(t),++w){v=t[w]
u=A.bf("^[a-z\\\\u00a1-\\\\uffff0-9-]+$",!0)
if(!u.b.test(v))return!1
if(v[0]!=="-")if(v[v.length-1]!=="-")u=A.aFa(v,"---",0)
else u=!0
else u=!0
if(u)return!1}return!0},
aEG:function aEG(){},
AG(d){var x
if(d.length!==0){x=C.c.gM(d)
C.c.dA(d,0)
return x}return null}},A,D,C
a.setFunctionNamesIfNecessary([B])
B=a.updateHolder(c[21],B)
A=c[0]
D=c[63]
C=c[2]
var z=a.updateTypes([])
B.adk.prototype={
$1(d){var x,w=this
if(!0===(d==null?null:d.length!==0)&&!B.b5y(d,w.d,w.f,w.e,w.a,w.c,w.b))x=w.r
else x=null
return x},
$S:138}
B.aEG.prototype={
$2(d,e){return A.dS(d,null)-A.dS(e,null)},
$S:371};(function inheritance(){var x=a.inherit
x(B.adk,A.bi)
x(B.aEG,A.f4)})()
A.cU(b.typeUniverse,JSON.parse("{}"))
var y={d:A.Q("j<i>")};(function constants(){var x=a.makeConstList
D.W6=A.a(x(["http","https","ftp"]),y.d)
D.adw=A.a(x(["http","https","ftp"]),A.Q("j<i?>"))})();(function lazyInitializers(){var x=a.lazy
x($,"bas","aTu",()=>A.bf("^(\\d?\\d?\\d)\\.(\\d?\\d?\\d)\\.(\\d?\\d?\\d)\\.(\\d?\\d?\\d)$",!0))
x($,"bat","aTv",()=>A.bf("^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$",!0))})()}
$__dart_deferred_initializers__["UsykikHhVKW+nwEtskbBjdGFFsQ="] = $__dart_deferred_initializers__.current
