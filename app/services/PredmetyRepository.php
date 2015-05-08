<?php

// Vybratie tried z databazy a sposob vypisu

class TriedyRepository
{

    /** @var Doctrine\DBAL\Connection */
    private $db;
    private $user;

    public function __construct(\Doctrine\DBAL\Connection $db, $session)
    {
        $this->db = $db;
        $this->user = $session->get('user');
    }
    
    public function getList()
    {
        $list = $this->db->fetchAll('SELECT id, rocnik, kod FROM triedy');
        
        $pair = array();
        foreach ($list as $trieda) {
            $pair[$trieda['id']] = ($trieda['rocnik']  < 4 ? str_repeat('I', $trieda['rocnik']) : 'IV').'. '.$trieda['kod'];
        }
        unset($list);
        
        return $pair;
    }
    
}
