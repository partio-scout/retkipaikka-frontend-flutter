self.$__dart_deferred_initializers__=self.$__dart_deferred_initializers__||Object.create(null)
$__dart_deferred_initializers__.current=function(a,b,c,$){var B={
aM2(d,e,f){return new B.adj(D.W8,!0,f,!1,C.bD,C.bD,e,d)},
adj:function adj(d,e,f,g,h,i,j,k){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i
_.r=j
_.x=k},
b5x(d,e,f,g,h,i,j){var x,w,v,u,t,s,r,q,p,o,n
if(d!=null){v=d.length
v=v===0||v>2083||C.b.bp(d,"mailto:")}else v=!0
if(v)return!1
x=null
w=null
v=y.d
u=A.a(d.split("://"),v)
if(u.length>1){if(!C.c.C(h,B.AB(u)))return!1}else if(i)return!1
u=A.a(C.c.bV(u,"://").split("#"),v)
d=B.AB(u)
t=C.c.bV(u,"#")
if(t.length!==0){s=A.bf("\\s",!0)
s=s.b.test(t)}else s=!1
if(s)return!1
u=A.a(d.split("?"),v)
d=B.AB(u)
r=C.c.bV(u,"?")
if(r.length!==0){s=A.bf("\\s",!0)
s=s.b.test(r)}else s=!1
if(s)return!1
u=A.a(d.split("/"),v)
d=B.AB(u)
q=C.c.bV(u,"/")
if(q.length!==0){s=A.bf("\\s",!0)
s=s.b.test(q)}else s=!1
if(s)return!1
u=A.a(d.split("@"),v)
if(u.length>1){p=B.AB(u)
s=p==null?null:C.b.C(p,":")
if(s===!0){s=B.AB(A.a(p.split(":"),v))
s.toString
o=A.bf("^\\S+$",!0)
if(!o.b.test(s))return!1
o=A.bf("^\\S*$",!0)
if(!o.b.test(s))return!1}}u=A.a(C.c.bV(u,"@").split(":"),v)
v=B.AB(u)
v.toString
if(u.length!==0){w=C.c.bV(u,":")
try{x=A.dN(w,10)}catch(n){return!1}s=A.bf("^[0-9]+$",!0)
o=w
if(!s.b.test(o)||x<=0||x>65535)return!1}if(!B.aIU(v,null)&&!B.b5t(v,!1,!0)&&v!=="localhost")return!1
return!0},
aIU(d,e){var x,w
if(e==null)return B.aIU(d,4)||B.aIU(d,6)
else if(e===4){x=$.aTq().b
if(!x.test(d))return!1
w=A.a(d.split("."),y.d)
C.c.dJ(w,new B.aEF())
return A.dN(w[3],null)<=255}if(e===6){x=$.aTr().b
x=x.test(d)}else x=!1
return x},
b5t(d,e,f){var x,w,v,u,t=A.a(d.split("."),y.d),s=t.pop()
if(t.length!==0){x=A.bf("^[a-z]{2,}$",!0)
x=!x.b.test(s)}else x=!0
if(x)return!1
for(x=t.length,w=0;w<t.length;t.length===x||(0,A.A)(t),++w){v=t[w]
u=A.bf("^[a-z\\\\u00a1-\\\\uffff0-9-]+$",!0)
if(!u.b.test(v))return!1
if(v[0]!=="-")if(v[v.length-1]!=="-")u=A.aF9(v,"---",0)
else u=!0
else u=!0
if(u)return!1}return!0},
aEF:function aEF(){},
AB(d){var x
if(d.length!==0){x=C.c.gM(d)
C.c.dA(d,0)
return x}return null}},A,D,C
a.setFunctionNamesIfNecessary([B])
B=a.updateHolder(c[17],B)
A=c[0]
D=c[48]
C=c[2]
var z=a.updateTypes([])
B.adj.prototype={
$1(d){var x,w=this
if(!0===(d==null?null:d.length!==0)&&!B.b5x(d,w.d,w.f,w.e,w.a,w.c,w.b))x=w.r
else x=null
return x},
$S:139}
B.aEF.prototype={
$2(d,e){return A.dN(d,null)-A.dN(e,null)},
$S:371};(function inheritance(){var x=a.inherit
x(B.adj,A.bv)
x(B.aEF,A.hX)})()
A.ev(b.typeUniverse,JSON.parse("{}"))
var y={d:A.T("k<i>")};(function constants(){var x=a.makeConstList
D.W8=A.a(x(["http","https","ftp"]),y.d)
D.adz=A.a(x(["http","https","ftp"]),A.T("k<i?>"))})();(function lazyInitializers(){var x=a.lazy
x($,"bar","aTq",()=>A.bf("^(\\d?\\d?\\d)\\.(\\d?\\d?\\d)\\.(\\d?\\d?\\d)\\.(\\d?\\d?\\d)$",!0))
x($,"bas","aTr",()=>A.bf("^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$",!0))})()}
$__dart_deferred_initializers__["W5t2xPsrhrFoy8hJgMeTsccqjsA="] = $__dart_deferred_initializers__.current
