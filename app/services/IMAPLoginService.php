<?php

// Prihlasovanie uzivatela

class IMAPLoginService
{
    private $state;
    /**
     *
     * @var Doctrine\DBAL\Connection
     */
    private $db;
    
    public function __construct($db)
    {
        $this->db = $db;
    }
    
    public function auth(User $loginUser)
    {
        
        $imap = true;
        
        if (!$imap) {
            return FALSE;
        } else if ($user = $this->db->fetchAssoc("SELECT p.id, p.heslo, p.meno, p.role, t.rocnik, t.kod, p.trieda_id FROM pouzivatelia AS p LEFT JOIN triedy AS t ON p.trieda_id = t.id WHERE p.login = ?", array($loginUser->getLogin()))) {
            return $user['heslo'] === md5($loginUser->getPassword()) ? $user : FALSE;
        } else {
            return FALSE;
        }
    }
}