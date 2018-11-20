function filterMobile(inp) {
    inp.on('input', function () {
        var val = inp.val().replace(/( |- )/ig, '');
        var num = '';
        for (i = 0; i < val.length; i++) {
            if (parseInt(val[i]) >= 0) {
                num += val[i]
            }
        }
        num=num.slice(0,11)
        inp.val(num)
    })
}