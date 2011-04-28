function nifval(nif){
  // NIF not provided
  if(!nif) return false;

  // Format
  if(!nif.match(/^[A-Z]{1}\d{7}[A-Z0-9]{1}$/) && !nif.match(/^[0-9]{8}[A-Z]{1}$/)) return false;

  if(nif.match(/^[0-9]{8}[A-Z]{1}$/)){
    // Standard NIF
    return nif[8] == "TRWAGMYFPDXBNJZSQVHLCKE"[parseInt(nif.substring(0,8),10) % 23];
  }else{
    // CIF algorithm
    var sum = parseInt(nif[2]) + parseInt(nif[4]) + parseInt(nif[6]);
    for (var i=1; i<9; i=i+2){
      var t = ""+(2*parseInt(nif[i]))+"";
      var t1 = parseInt(t[0]);
      var t2 = (t.length==2)?parseInt(t[1]):0;
      sum += t1+t2;
    }
    var sumstr = ""+sum+"";
    var n = 10 - parseInt(sumstr[sumstr.length-1]);

    if(nif.match(/^[KLM]{1}/)){
      // Special NIFs (as CIFs)
      return nif[8] == String.fromCharCode(64+n);
    }else if(nif.match(/^[ABCDEFGHJNPQRSUVW]{1}/)){
      // CIFs
      var nstr = ""+n+"";
      return (parseInt(nif[8]) == String.fromCharCode(64+n)) || (nif[8] == nstr[nstr.length-1]);
    }else if(nif.match(/^[XYZ]{1}/)){
      // NIE
      var niff = nif.replace("X",0).replace("Y",1).replace("Z",2);
      return nif[8] == "TRWAGMYFPDXBNJZSQVHLCKE"[parseInt(niff.substring(0,8),10) % 23];
    }else{
      return false
    }
  }
}
