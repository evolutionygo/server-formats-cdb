--転生炎獣 ラクーン (Anime)
--Salamangreat Raccoon (Anime)
--Scripted by Larry126
local s,c511600362,alias=GetID()
function c511600362.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Gain LP
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600362(alias,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511600362.lpcon)
	e1:SetCost(c511600362.lpcost)
	e1:SetTarget(c511600362.lptg)
	e1:SetOperation(c511600362.lpop)
	c:RegisterEffect(e1)
end
c511600362.listed_series={0x119}
function c511600362.lpcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x119)
end
function c511600362.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511600362.lpfilter(c,e)
	return c and c:IsOnField() and c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function c511600362.lptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	local tg=Duel.GetAttackTarget()
	if chkc then return chkc==at or chkc==tg end
	if chk==0 then return c511600362.lpfilter(at,e) and c511600362.lpfilter(tg,e) end
	local g=Group.FromCards(at,tg)
	Duel.SetTargetCard(g)
	local rec=at:GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c511600362.lpop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e)
	local at=Duel.GetAttacker()
	if at and g:IsContains(at) and at:IsFaceup() then
		Duel.Recover(tp,at:GetAttack(),REASON_EFFECT)
	end
	local tg=g:Filter(Card.IsControler,nil,tp):GetFirst()
	if tg and tg:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tg:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetTargetRange(0,1)
	e2:SetValue(1)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end