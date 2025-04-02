--ユベル
--Yubel
function c78371393.initial_effect(c)
	--Cannot be destroyed by battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--You take no battle damage from battles involving this card
	local e2=e1:Clone()
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e2)
	--Register that this card was in face-up Attack Position when it was targeted for an attack
	local e3a=Effect.CreateEffect(c)
	e3a:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3a:SetCode(EVENT_BE_BATTLE_TARGET)
	e3a:SetOperation(c78371393.regop)
	c:RegisterEffect(e3a)
	--Inflict damage to your opponent equal to the attacking monster's ATK
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc78371393(c78371393,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetCondition(c78371393.damcon)
	e3:SetTarget(c78371393.damtg)
	e3:SetOperation(c78371393.damop)
	c:RegisterEffect(e3)
	--Tribute 1 other monster or destroy this card
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc78371393(c78371393,1))
	e4:SetCategory(CATEGORY_RELEASE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
	e4:SetTarget(c78371393.destg)
	e4:SetOperation(c78371393.desop)
	c:RegisterEffect(e4)
	--Special Summon 1 "Yubel - Terror Incarnate" from your hand, Deck, or GY
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc78371393(c78371393,2))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return re~=e4 end)
	e5:SetTarget(c78371393.sptg)
	e5:SetOperation(c78371393.spop)
	c:RegisterEffect(e5)
end
c78371393.listed_names={4779091} --"Yubel - Terror Incarnate"
function c78371393.regop(e)
	local c=e:GetHandler()
	if c==Duel.GetAttackTarget() and c:IsPosition(POS_FACEUP_ATTACK) then
		c:RegisterFlagEffect(c78371393,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_DAMAGE,0,1)
	else
		c:ResetFlagEffect(c78371393)
	end
end
function c78371393.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:HasFlagEffect(c78371393) and c==Duel.GetAttackTarget()
end
function c78371393.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Duel.GetAttacker():GetAttack())
end
function c78371393.damop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	if ac:IsRelateToBattle() then
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		Duel.Damage(p,ac:GetAttack(),REASON_EFFECT)
	end
end
function c78371393.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	if not Duel.CheckReleaseGroup(tp,Card.IsReleasableByEffect,1,c) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,tp,0)
	end
	Duel.SetPossibleOperationInfo(0,CATEGORY_RELEASE,nil,1,tp,LOCATION_MZONE)
	Duel.SetPossibleOperationInfo(0,CATEGORY_DESTROY,c,1,tp,0)
end
function c78371393.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local b1=Duel.CheckReleaseGroup(tp,Card.IsReleasableByEffect,1,c)
	local b2=true
	--Tribute 1 other monster or destroy this card
	local op=b1 and Duel.SelectEffect(tp,
		{b1,aux.Stringc78371393(c78371393,3)},
		{b2,aux.Stringc78371393(c78371393,4)}) or 2
	if op==1 then
		local g=Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,1,1,c)
		if #g==0 then return end
		Duel.HintSelection(g)
		Duel.Release(g,REASON_EFFECT)
	elseif op==2 then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
function c78371393.spfilter(c,e,tp)
	return c:IsCode(4779091) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c78371393.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c78371393.spfilter,tp,LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE)
end
function c78371393.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c78371393.spfilter),tp,LOCATION_HAND|LOCATION_DECK|LOCATION_GRAVE,0,1,1,nil,e,tp):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,true,true,POS_FACEUP)>0 then
		sc:CompleteProcedure()
	end
end