--Ｄ－ＨＥＲＯ ダガーガイ (Anime)
--Destiny HERO - Blade Master (Anime)
local s,c511027000,alias=GetID()
function c511027000.initial_effect(c)
	local alias=c:GetOriginalCodeRule()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511027000(alias,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511027000.atkcon)
	e1:SetCost(c511027000.atkcost)
	e1:SetTarget(c511027000.atktg)
	e1:SetOperation(c511027000.atkop)
	c:RegisterEffect(e1)
end
c511027000.listed_series={0xc008}
function c511027000.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and (ph~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c511027000.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c511027000.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc008)
end
function c511027000.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511027000.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511027000.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511027000.filter,tp,LOCATION_MZONE,0,nil)
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetOwnerPlayer(tp)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end