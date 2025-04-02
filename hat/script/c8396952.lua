--アルカナフォースⅠ－THE MAGICIAN
--Arcana Force I - The Magician
function c8396952.initial_effect(c)
	--Toss a coin and apply the appropirate effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc8396952(c8396952,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c8396952.cointg)
	e1:SetOperation(c8396952.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
c8396952.toss_coin=true
function c8396952.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c8396952.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	c8396952.arcanareg(c,Arcana.TossCoin(c,tp))
end
function c8396952.arcanareg(c,coin)
	--Apply effect when a Spell Card is activated
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c8396952.speop)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD)
	c:RegisterEffect(e1)
	Arcana.RegisterCoinResult(c,coin)
end
function c8396952.speop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsSpellEffect() or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local c=e:GetHandler()
	local val=Arcana.GetCoinResult(c)
	if val==COIN_HEADS then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE|RESET_PHASE|PHASE_END)
		c:RegisterEffect(e1)
	elseif val==COIN_TAILS then
		Duel.Recover(1-tp,500,REASON_EFFECT)
	end
end