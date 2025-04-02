--ガガガザムライ (Anime)
--Gagaga Samurai (Anime)
--Scripted by Larry126
function c511600369.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--attack twice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600369(c511600369,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511600369.atcon)
	e1:SetCost(c511600369.atcost)
	e1:SetTarget(c511600369.attg)
	e1:SetOperation(c511600369.atop)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600369(c511600369,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511600369.cbcon)
	e2:SetOperation(c511600369.cbop)
	c:RegisterEffect(e2)
end
c511600369.listed_series={0x54}
function c511600369.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c511600369.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511600369.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x54) and c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0
end
function c511600369.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600369.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511600369.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511600369.filter,tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511600369.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and bt~=e:GetHandler() and bt:IsControler(tp)
		and bt:IsFaceup() and bt:IsSetCard(0x54) and e:GetHandler():IsPosition(POS_ATTACK)
end
function c511600369.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) and Duel.ChangePosition(c,POS_FACEUP_DEFENSE)~=0 then
		local at=Duel.GetAttacker()
		if at:CanAttack() and not at:IsImmuneToEffect(e) and not c:IsImmuneToEffect(e) then
			Duel.CalculateDamage(at,c)
		end
	end
end