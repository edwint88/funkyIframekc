<html>
<head>
    <title>Hello World!</title>
</head>
<body>
<h1>Hello World!</h1>
<p>
    It is now
    <%= new java.util.Date() %></p>

<script type="application/javascript">
    var xhrAT = new XMLHttpRequest(), token;
    xhrAT.open('GET', 'http://localhost:8080/auth/realms/demo/protocol/openid-connect/token?client_id=demo&grant_type=password&username=demo&password=demodemo');
    xhrAT.onreadystatechange = getToken;
    xhrAT.send();

    var xhr = new XMLHttpRequest();

    xhr.open('GET', 'https://localhost:7003/canvasApp');
    xhr.onreadystatechange = handler;
    xhr.responseType = 'blob';
    xhr.setRequestHeader('Authorization', 'Bearer ' + token);
    xhr.send();

    function getToken() {
        if (this.readyState === this.DONE) {
            if (this.status === 200) {
                // this.response is a Blob, because we set responseType above
                token = this.response.accessToken;
            } else {
                console.error('no token');
            }
        }
    }
    function handler() {
        if (this.readyState === this.DONE) {
            if (this.status === 200) {
                // this.response is a Blob, because we set responseType above
                var data_url = URL.createObjectURL(this.response);
                document.querySelector('#canvasApp').src = data_url;
            } else {
                console.error('no app');
            }
        }
    }
</script>

<iframe id="canvasApp" width="800" height="1000"/>
</body>