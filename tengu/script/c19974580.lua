--C・ドラゴン
--Iron Chain Dragon
function c19974580.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon procedure: 1 Tuner + 1 or more non-Tuner monsters
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	--Gains 200 ATK for each "Iron Chain" monster banished
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc19974580(c19974580,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c19974580.attg)
	e1:SetOperation(c19974580.atop)
	c:RegisterEffect(e1)
	--Send the top 3 cards of your opponent's Deck to the GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc19974580(c19974580,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c19974580.ddcon)
	e2:SetTarget(c19974580.ddtg)
	e2:SetOperation(c19974580.ddop)
	c:RegisterEffect(e2)
end
c19974580.listed_series={SET_IRON_CHAIN}
function c19974580.rfilter(c)
	return c:IsSetCard(SET_IRON_CHAIN) and c:IsMonster() and c:IsAbleToRemove() and aux.SpElimFilter(c,true)
end
function c19974580.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19974580.rfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_SPIRIT_ELIMINATION) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_MZONE)
	else
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
	end
end
function c19974580.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c19974580.rfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*200)
		e1:SetReset(RESETS_STANDARD_DISABLE_PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c19974580.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c19974580.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,3)
end
function c19974580.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end