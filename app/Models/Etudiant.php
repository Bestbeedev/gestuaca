<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class Etudiant extends Model
{
    protected $fillable = [
        'matricule',
        'filiere',
        'solde',
        'statut_compte',
        'statut',
        'date_naissance',
        'sexe',
        'id_user'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function inscriptions()
    {
        return $this->hasMany(Inscription::class);
    }

    public function paiements()
    {
        return $this->hasMany(Paiement::class);
    }

    
}
