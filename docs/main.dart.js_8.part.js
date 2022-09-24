self.$__dart_deferred_initializers__=self.$__dart_deferred_initializers__||Object.create(null)
$__dart_deferred_initializers__.current=function(a,b,c,$){var B={
aOv(d,e){return new B.aeV(D.Wh,!0,e,!1,C.bB,C.bB,d)},
aeV:function aeV(d,e,f,g,h,i,j){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i
_.r=j},
b8c(d,e,f,g,h,i,j){var x,w,v,u,t,s,r,q,p,o,n
if(d!=null){v=d.length
v=v===0||v>2083||C.b.bj(d,"mailto:")}else v=!0
if(v)return!1
x=null
w=null
v=y.d
u=A.a(d.split("://"),v)
if(u.length>1){if(!C.c.C(h,B.Bn(u)))return!1}else if(i)return!1
u=A.a(C.c.bM(u,"://").split("#"),v)
d=B.Bn(u)
t=C.c.bM(u,"#")
if(t.length!==0){s=A.bk("\\s",!0)
s=s.b.test(t)}else s=!1
if(s)return!1
u=A.a(d.split("?"),v)
d=B.Bn(u)
r=C.c.bM(u,"?")
if(r.length!==0){s=A.bk("\\s",!0)
s=s.b.test(r)}else s=!1
if(s)return!1
u=A.a(d.split("/"),v)
d=B.Bn(u)
q=C.c.bM(u,"/")
if(q.length!==0){s=A.bk("\\s",!0)
s=s.b.test(q)}else s=!1
if(s)return!1
u=A.a(d.split("@"),v)
if(u.length>1){p=B.Bn(u)
s=p==null?null:C.b.C(p,":")
if(s===!0){s=B.Bn(A.a(p.split(":"),v))
s.toString
o=A.bk("^\\S+$",!0)
if(!o.b.test(s))return!1
o=A.bk("^\\S*$",!0)
if(!o.b.test(s))return!1}}u=A.a(C.c.bM(u,"@").split(":"),v)
v=B.Bn(u)
v.toString
if(u.length!==0){w=C.c.bM(u,":")
try{x=A.eo(w,10)}catch(n){return!1}s=A.bk("^[0-9]+$",!0)
o=w
if(!s.b.test(o)||x<=0||x>65535)return!1}if(!B.aLp(v,null)&&!B.b88(v,!1,!0)&&v!=="localhost")return!1
return!0},
aLp(d,e){var x,w
if(e==null)return B.aLp(d,4)||B.aLp(d,6)
else if(e===4){x=$.aW2().b
if(!x.test(d))return!1
w=A.a(d.split("."),y.d)
C.c.du(w,new B.aGU())
return A.eo(w[3],null)<=255}if(e===6){x=$.aW3().b
x=x.test(d)}else x=!1
return x},
b88(d,e,f){var x,w,v,u,t=A.a(d.split("."),y.d),s=t.pop()
if(t.length!==0){x=A.bk("^[a-z]{2,}$",!0)
x=!x.b.test(s)}else x=!0
if(x)return!1
for(x=t.length,w=0;w<t.length;t.length===x||(0,A.A)(t),++w){v=t[w]
u=A.bk("^[a-z\\\\u00a1-\\\\uffff0-9-]+$",!0)
if(!u.b.test(v))return!1
if(v[0]!=="-")if(v[v.length-1]!=="-")u=A.aHt(v,"---",0)
else u=!0
else u=!0
if(u)return!1}return!0},
aGU:function aGU(){},
Bn(d){var x
if(d.length!==0){x=C.c.gL(d)
C.c.ds(d,0)
return x}return null}},A,D,C
B=a.updateHolder(c[22],B)
A=c[0]
D=c[59]
C=c[2]
var z=a.updateTypes([])
B.aeV.prototype={
$1(d){var x,w=this
if(!0===(d==null?null:d.length!==0)&&!B.b8c(d,w.d,w.f,w.e,w.a,w.c,w.b))x=w.r
else x=null
return x},
$S:148}
B.aGU.prototype={
$2(d,e){return A.eo(d,null)-A.eo(e,null)},
$S:382};(function inheritance(){var x=a.inherit
x(B.aeV,A.bq)
x(B.aGU,A.ig)})()
A.dj(b.typeUniverse,JSON.parse("{}"))
var y={d:A.T("j<f>")};(function constants(){var x=a.makeConstList
D.Wh=A.a(x(["http","https","ftp"]),y.d)
D.adM=A.a(x(["http","https","ftp"]),A.T("j<f?>"))})();(function lazyInitializers(){var x=a.lazy
x($,"bdf","aW2",()=>A.bk("^(\\d?\\d?\\d)\\.(\\d?\\d?\\d)\\.(\\d?\\d?\\d)\\.(\\d?\\d?\\d)$",!0))
x($,"bdg","aW3",()=>A.bk("^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$",!0))})()}
$__dart_deferred_initializers__["0jikgscM8pSluBgywnV59//o+Vs="] = $__dart_deferred_initializers__.current
