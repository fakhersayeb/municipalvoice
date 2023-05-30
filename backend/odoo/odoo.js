var Odoo = require('odoo-xmlrpc');
const express = require('express');
const router = express.Router();
const fs = require('fs');
var atob = require('atob');
var mod="test";
var link;
 if(mod=="dev"){
     link='https://tbge-13-0-claiming-module-obs.review.odoo.whitecapetech.com/web/login';
 }
 if(mod=="test"){
    link='https://tbge-test.odoo.whitecapetech.com/web';
}
if(mod=="prod"){
    link='https://tbge-staging.odoo.whitecapetech.com';
}
console.log(link)
var odoo = new Odoo({
    url: link,
    db: 'tbge',
    username: 'pfe@mail.com',
    password: 'pfe@2021'
});


odoo.connect(function (err) {
    if (err) { return console.log(err); }
    console.log('Connected to Odoo server.');
});
router.post('/info',async(req,res)=>{
    name=req.body.name;
    commentaire=req.body.description;
    date=req.body.date;
    
    var inParams = [];
       inParams.push({'name':name,'description':commentaire,'date_claiming':date,'claiming_type':'information','domain':'lighting'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('information envoyée')
           }
       });
})
router.post('/prop',async(req,res)=>{

    name=req.body.name;
    des=req.body.description;
    date=req.body.date;
    
    console.log(des)
    var inParams = [];
       inParams.push({'name':name,'description':des,'date_claiming':date,'claiming_type':'proposal','domain':'lighting'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('proposition envoyée')
           }
       });
})
router.post('/rec',async(req,res)=>{
    name=req.body.name;
    commentaire=req.body.commentaire;
    adresse=req.body.adresse;
   
    status=req.body.id;
    date=req.body.date;
    type=req.body.type;
    name1=req.body.name1;
    name2=req.body.name2;
    name3=req.body.name3;
    name4=req.body.name4;
    name5=req.body.name5;
    name6=req.body.name6;
    nm=req.body.nom;
    pre=req.body.prenom;
    em=req.body.email;
    longi=req.body.longitude;
    latit=req.body.latitude;
    adr=req.body.adr;
    console.log(name4)
    console.log(name5)
    console.log(name6)
    console.log(adresse)
  
    
    var st;
    if(status=='hors service' || status=='خارج الخدمة')
    {
      st='draft';
    }
   

       var nb;
    var inParams = [];
    inParams.push([['name', '=', adresse]]);
    inParams.push(['id']); //fields
   
    var params = [];
    params.push(inParams);
    odoo.execute_kw('maintenance.equipment', 'search_read', params, function (err, value) {
        if (err) { return console.log(err); }
        console.log('Result: ', value);
       let d= JSON.stringify(value);
       domaine='lighting';
        console.log(d)
        nb=d.substring(7,12);
        var id=parseInt(nb);
        console.log(id)
    
        console.log(name);
    console.log(commentaire);
    if(name1==null && name2==null && name3==null){
        var inParams = [];
       inParams.push({'name':name,'status':st,'description':commentaire,'longitude':longi,'latitude':latit,'claim_type_id':type,'claimer_firstname':pre,'claimer_lastname':nm,'email':em,'claimer_address':adr,'code_equipment':adresse,'equipment_id':id,'domain':'lighting','date_claiming':date,'claiming_type':'reclamation'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('réclamation envoyée')
           }
       });
    }
    if(name2==null && name3==null){
        var datas=JSON.stringify(name1);
        
        var inParams = [];
            inParams.push({'datas':datas,'name':name4})
            var params = [];
             params.push(inParams);
            //console.log(inParams)
            //console.log(data)
            //console.log(fileName)
            var imgid;
            odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                if (err)  {return console.log(err);}
               else{console.log('Result: ', val);
               let va=  JSON.stringify(val);
                 imgid=parseInt(va);
                console.log(imgid)
                 
                console.log('ok,it is send')
                 
       
       var inParams = [];
       inParams.push({'name':name,'status':st,'description':commentaire,'longitude':longi,'latitude':latit,'claim_type_id':type,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':adr,'equipment_id':id,'image_ids':(6, 0, [imgid]),'domain':'lighting','date_claiming':date,'claiming_type':'reclamation'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('réclamation envoyée')
           }
       });
    }

});
}
if( name3==null){
    var datas=JSON.stringify(name1);
    var datas2=JSON.stringify(name2);
    var imgid,imgid2;
    var imglist=[];
    var inParams = [];
        inParams.push({'datas':datas,'name':name4})
        var params = [];
         params.push(inParams);
        
        odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
            if (err)  {return console.log(err);}
           else{console.log('Result: ', val);
           let va=  JSON.stringify(val);
             imgid=parseInt(va);
            console.log(imgid)
             imglist.push(imgid)
            console.log('ok,it is send')
            var inParams = [];
            inParams.push({'datas':datas2,'name':name5})
            var params = [];
             params.push(inParams);
            
            odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                if (err)  {return console.log(err);}
               else{console.log('Result: ', val);
               let va=  JSON.stringify(val);
                 imgid2=parseInt(va);
                console.log(imgid2)
                 imglist.push(imgid2)
                console.log('ok,it is send')
   
   var inParams = [];
   inParams.push({'name':name,'status':st,'description':commentaire,'longitude':longi,'latitude':latit,'claim_type_id':type,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':adr,'equipment_id':id,'image_ids':(6, 0, imglist),'domain':'lighting','date_claiming':date,'claiming_type':'reclamation'})
   var params = [];
    params.push(inParams);
   console.log(inParams)
   odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
       if (err) {  console.log(err);
       res.send('erreur')
       }
       else{
            console.log('Result: ', v);
            res.send('réclamation envoyée')
       }
   });
}
});
}
});
}        
if( name1!=null && name2!=null && name3!=null){
    var datas=JSON.stringify(name1);
    var datas2=JSON.stringify(name2);
    var datas3=JSON.stringify(name3);
    var imgid,imgid2,imgid3;
    var imglist=[];
    var inParams = [];
        inParams.push({'datas':datas,'name':name4})
        var params = [];
         params.push(inParams);
        
        odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
            if (err)  {return console.log(err);}
           else{console.log('Result: ', val);
           let va=  JSON.stringify(val);
             imgid=parseInt(va);
            console.log(imgid)
             imglist.push(imgid)
            console.log('ok,it is send')
            var inParams = [];
            inParams.push({'datas':datas2,'name':name5})
            var params = [];
             params.push(inParams);
            
            odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                if (err)  {return console.log(err);}
               else{console.log('Result: ', val);
               let va=  JSON.stringify(val);
                 imgid2=parseInt(va);
                console.log(imgid2)
                 imglist.push(imgid2)
                console.log('ok,it is send')
                var inParams = [];
                inParams.push({'datas':datas3,'name':name6})
                var params = [];
                 params.push(inParams);
                
                odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                    if (err)  {return console.log(err);}
                   else{console.log('Result: ', val);
                   let va=  JSON.stringify(val);
                     imgid3=parseInt(va);
                    console.log(imgid3)
                     imglist.push(imgid3)
                    console.log('ok,it is send')
   var inParams = [];
   inParams.push({'name':name,'status':st,'description':commentaire,'longitude':longi,'latitude':latit,'claim_type_id':type,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':adr,'equipment_id':id,'image_ids':(6, 0, imglist),'domain':'lighting','date_claiming':date,'claiming_type':'reclamation'})
   var params = [];
    params.push(inParams);
   console.log(inParams)
   odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
       if (err) {  console.log(err);
       res.send('erreur')
       }
       else{
            console.log('Result: ', v);
            res.send('réclamation envoyée')
       }
   });
}
});
}
});
}
});
 } 
}); 
   
});
 
    router.delete('/delete',async(req,res)=>{
        var inParams = [];
        inParams.push([154]); //id to delete
        var params = [];
        params.push(inParams);
        odoo.execute_kw('maintenance.request', 'unlink', params, function (err, value) {
            if (err) { return console.log(err); }
            console.log('Result: ', value);
            res.send('ok')
        });
    })
    router.post('/rec2',async(req,res)=>{
        
        name=req.body.name;
        longi=req.body.longi;
        latit=req.body.latit;
        status=req.body.id;
        date=req.body.date;
        type=req.body.type;
        name1=req.body.name1;
        name2=req.body.name2;
        name3=req.body.name3;
        name4=req.body.name4;
        name5=req.body.name5;
        name6=req.body.name6;
        nm=req.body.nom;
        pre=req.body.prenom;
        em=req.body.email;
        ad=req.body.adr;
        console.log(name4)
        console.log(name5)
        console.log(name6)
        console.log(longi);
        console.log(latit);
        console.log(type)
        var longitude;
        var latitude;
        longitude=parseFloat(longi);
        latitude=parseFloat(latit);
        type=req.body.type;
                var st;
        if(status=='hors service' || status=='خارج الخدمة')
        {
          st='draft';
        } 
            console.log(name);
            if(name1==null && name2==null && name3==null){
                var inParams = [];
       inParams.push({'name':name,'status':st,'longitude':longi,'latitude':latit,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':ad,'domain':'lighting','date_claiming':date,'claim_type_id':type,'claiming_type':'reclamation'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('réclamation envoyée')
           }
       });
            }
       if(name2==null && name3==null){
        var datas=JSON.stringify(name1);
        
        var inParams = [];
            inParams.push({'datas':datas,'name':name4})
            var params = [];
             params.push(inParams);
            var imgid;
            odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                if (err)  {return console.log(err);}
               else{console.log('Result: ', val);
               let va=  JSON.stringify(val);
                 imgid=parseInt(va);
                console.log(imgid)
                console.log('ok,it is send')
                 
       
       var inParams = [];
       inParams.push({'name':name,'status':st,'longitude':longi,'latitude':latit,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':ad,'image_ids':(6, 0, [imgid]),'domain':'lighting','date_claiming':date,'claim_type_id':type,'claiming_type':'reclamation'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('réclamation envoyée')
           }
       });
}

    });
       
       }
       if( name3==null){
        var datas=JSON.stringify(name1);
        var datas2=JSON.stringify(name2);
        var imgid,imgid2;
        var imglist=[];
        var inParams = [];
            inParams.push({'datas':datas,'name':name4})
            var params = [];
             params.push(inParams);
            
            odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                if (err)  {return console.log(err);}
               else{console.log('Result: ', val);
               let va=  JSON.stringify(val);
                 imgid=parseInt(va);
                console.log(imgid)
                 imglist.push(imgid)
                console.log('ok,it is send')
                var inParams = [];
                inParams.push({'datas':datas2,'name':name5})
                var params = [];
                 params.push(inParams);
                
                odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                    if (err)  {return console.log(err);}
                   else{console.log('Result: ', val);
                   let va=  JSON.stringify(val);
                     imgid2=parseInt(va);
                    console.log(imgid2)
                     imglist.push(imgid2)
                    console.log('ok,it is send')
       
       var inParams = [];
       inParams.push({'name':name,'status':st,'longitude':longi,'latitude':latit,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':ad,'image_ids':(6, 0, imglist),'domain':'lighting','date_claiming':date,'claim_type_id':type,'claiming_type':'reclamation'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('réclamation envoyée')
           }
       });
}
});
}
    });
    }

    if( name1!=null && name2!=null && name3!=null){
        var datas=JSON.stringify(name1);
        var datas2=JSON.stringify(name2);
        var datas3=JSON.stringify(name3);
        var imgid,imgid2,imgid3;
        var imglist=[];
        var inParams = [];
            inParams.push({'datas':datas,'name':name4})
            var params = [];
             params.push(inParams);
            
            odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                if (err)  {return console.log(err);}
               else{console.log('Result: ', val);
               let va=  JSON.stringify(val);
                 imgid=parseInt(va);
                console.log(imgid)
                 imglist.push(imgid)
                console.log('ok,it is send')
                var inParams = [];
                inParams.push({'datas':datas2,'name':name5})
                var params = [];
                 params.push(inParams);
                
                odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                    if (err)  {return console.log(err);}
                   else{console.log('Result: ', val);
                   let va=  JSON.stringify(val);
                     imgid2=parseInt(va);
                    console.log(imgid2)
                     imglist.push(imgid2)
                    console.log('ok,it is send')
                    var inParams = [];
                    inParams.push({'datas':datas3,'name':name6})
                    var params = [];
                     params.push(inParams);
                    
                    odoo.execute_kw('ir.attachment', 'create', params, async function (err, val) {
                        if (err)  {return console.log(err);}
                       else{console.log('Result: ', val);
                       let va=  JSON.stringify(val);
                         imgid3=parseInt(va);
                        console.log(imgid3)
                         imglist.push(imgid3)
                        console.log('ok,it is send')
       var inParams = [];
       inParams.push({'name':name,'status':st,'longitude':longi,'latitude':latit,'claimer_firstname':nm,'claimer_lastname':pre,'email':em,'claimer_address':ad,'image_ids':(6, 0, imglist),'domain':'lighting','date_claiming':date,'claim_type_id':type,'claiming_type':'reclamation'})
       var params = [];
        params.push(inParams);
       console.log(inParams)
       odoo.execute_kw('tbge.claiming', 'create', params, async function (err, v) {
           if (err) {  console.log(err);
           res.send('erreur')
           }
           else{
                console.log('Result: ', v);
                res.send('réclamation envoyée')
           }
       });
}
});
}
});
}
    });
     }  
        
        
       
   
    
});
   
     
        
          
        
      
    router.get('/id',async(req,res)=>{
      
            var inParams=[];
            inParams.push([['claim_type_id','=',15]]);
            inParams.push(['name','status','description']); //fields
            var params = [];
            params.push(inParams);
            odoo.execute_kw('tbge.claiming', 'search_read', params, function (err, value) {
                if (err) { return console.log(err); }
                let data=JSON.stringify(value)
                console.log('Result: ', data);
                res.send(data) 
            });
    })
    router.get('/idf',async(req,res)=>{
      
        var inParams=[];
        inParams.push([['claim_type_id','=',16]]);
        inParams.push(['name', 'status', 'date_claiming','claim_type_id','image_ids']); //fields
        var params = [];
        params.push(inParams);
        odoo.execute_kw('tbge.claiming', 'search_read', params, function (err, value) {
            if (err) { return console.log(err); }
            let data=JSON.stringify(value)
            console.log('Result: ', data);
            res.send(data) 
        });
})
router.get('/idp',async(req,res)=>{
      
    var inParams=[];
    inParams.push([['claim_type_id', '=', 17]]);
    inParams.push(['name', 'status', 'date_claiming','claim_type_id','image_ids']); //fields
    var params = [];
    params.push(inParams);
    odoo.execute_kw('tbge.claiming', 'search_read', params, function (err, value) {
        if (err) { return console.log(err); }
        let data=JSON.stringify(value)
        console.log('Result: ', data);
        res.send(data) 
    });
})
router.get('/ids',async(req,res)=>{
      
    var inParams=[];
    inParams.push([['claim_type_id', '=', 18]]);
    inParams.push(['name', 'status', 'date_claiming','claim_type_id','image_ids']); //fields
    var params = [];
    params.push(inParams);
    odoo.execute_kw('tbge.claiming', 'search_read', params, function (err, value) {
        if (err) { return console.log(err); }
        let data=JSON.stringify(value)
        console.log('Result: ', data);
        res.send(data) 
    });
})


  router.put('/update',(req,res)=>{
      const {adresse,name}=req.body;
      console.log(adresse);
      console.log(name);
      var inParams = [];
      inParams.push([['name', '=', adresse]]);
      inParams.push(['id']); //fields
     // inParams.push(0); //offset
     // inParams.push(5); //limit
      var params = [];
      params.push(inParams);
      odoo.execute_kw('maintenance.equipment', 'search_read', params, function (err, value) {
          if (err) { return console.log(err); }
          console.log('Result: ', value);
         let data= JSON.stringify(value);
          
          console.log(data)
          nb=data.substring(7,12);
          console.log(nb)
          var id=parseInt(nb);
          console.log(id)
          var inParams = [];
      inParams.push([['equipment_id', '=', id]]);
      inParams.push(['id']); //fields
     // inParams.push(0); //offset
     // inParams.push(5); //limit
      var params = [];
      params.push(inParams);
      odoo.execute_kw('maintenance.request', 'search_read', params, function (err, value) {
          if (err) { return console.log(err); }
          console.log('Result: ', value);
          let d= JSON.stringify(value);
          
          console.log(d)
          nb2=d.substring(7,10);
          console.log(nb2)
          var id2=parseInt(nb2);
          console.log(id2)
          var inParams = [];
    inParams.push([id2]); //id to update
    inParams.push({'status': name})
    var params = [];
    params.push(inParams);
    odoo.execute_kw('maintenance.request', 'write', params, function (err, value) {
        if (err) { return console.log(err); }
        console.log('Result: ', value);
        res.send('réclamation modifiée')
    });
      });
      });
   
  })


module.exports=router;