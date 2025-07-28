<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Paiement extends Model
{
    protected $fillable = ['reference', 'montant', 'mode_paiement', 'date_paiement', 'motif', 'id_etudiant'];

    public function etudiant()
    {
        return $this->belongsTo(Etudiant::class);
    }
}
