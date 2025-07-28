<?php

use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('paiements', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(User::class)->constrained()->onDelete('cascade');
            $table->decimal('montant', 10, 2); // Montant du paiement
            $table->dateTime('date_paiement'); // Date du paiement
            $table->enum ('mode_paiement', ['mobile_money', 'paypal', 'bank_transfer', 'cash'])->default('mobile_money'); // Mode de paiement
            $table->string('motif')->nullable(); // Motif du paiement
            $table->string('reference')->unique(); // Référence du paiement
            $table->string('statut')->default('pending'); // Statut du paiement, e.g., 'pending', 'completed', 'failed'
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('paiements');
    }
};
