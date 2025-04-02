--ダイナレスラー・カパプテラ
--Dinowrestler Capaptera (Anime)
--scripted by Hatter
function c511106005.initial_effect(c)
	--be material
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c511106005.ddcon)
	e1:SetTarget(c511106005.ddtg)
	e1:SetOperation(c511106005.ddop)
	c:RegisterEffect(e1)
end
function c511106005.ddcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	return c:IsLocation(LOCATION_GRAVE) and r & REASON_LINK == REASON_LINK
		and rc:IsSetCard(0x11a) and rc:IsLinkMonster()
end
function c511106005.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(e:GetHandler():GetReasonCard())
end
function c511106005.ddop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=c:GetReasonCard()
	if sync:IsRelateToEffect(e) and sync:IsFaceup() and sync:IsSetCard(0x11a) and sync:IsLinkMonster() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		sync:RegisterEffect(e1) 
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		e2:SetTarget(c511106005.target)
		sync:RegisterEffect(e2)
	end
end
function c511106005.target(e,c)
	return c~=e:GetHandler()
end