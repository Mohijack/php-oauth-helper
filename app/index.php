<?php

// Hole Umgebungsvariable oder verwende Standardwert
$authServerUrl = "https://web3.isolarcloud.eu/#/authorized-app";
$redirectUri = getenv('REDIRECT_URI') ;
$clientCallbackUri = "https://my.home-assistant.io/redirect/oauth";

// Starte den OAuth Flow
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['state']) && !isset($_GET['code'])) {
    $state = $_GET['state'];

    setcookie("oauth_state", $state, [
        'expires' => time() + 300,
        'httponly' => true,
        'secure' => true,
        'samesite' => 'Lax'
    ]);

    if (isset($_GET['cloudUrl'])) {
        $authServerUrl = $_GET['cloudUrl'];
    }

    $authUrl = $authServerUrl . '?' . http_build_query([
        'cloudId' => $_GET['cloudId'],
        'applicationId' => $_GET['applicationId'],
        'redirectUrl' => $redirectUri
    ]);

    header("Location: $authUrl");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['code'])) {
    $state = $_COOKIE['oauth_state'] ?? null;
    if (!$state) {
        http_response_code(400);
        echo "Error: Missing state parameter";
        exit;
    }

    setcookie("oauth_state", "", time() - 3600);

    $clientRedirectUrl = $clientCallbackUri . '?' . http_build_query([
        'code' => $_GET['code'],
        'state' => $state
    ]);

    header("Location: $clientRedirectUrl");
    exit;
}

http_response_code(400);
echo "Invalid request";
exit;
