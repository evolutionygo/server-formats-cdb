--煉獄龍 オーガ・ドラグーン
--Voc511002200 Ogre Dragon (Manga)
function c511002200.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon Procedure
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	--Negate the activation of Spell/Trap Cards
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002200(c511002200,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002200.discon)
	e1:SetTarget(c511002200.distg)
	e1:SetOperation(c511002200.disop)
	c:RegisterEffect(e1)
	--Increase its own ATK by 500
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511002200(c511002200,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(c511002200)
	e2:SetOperation(c511002200.atkop)
	c:RegisterEffect(e2)
end
function c511002200.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c511002200.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511002200.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.RaiseSingleEvent(c,c511002200,e,r,rp,ep,0)
	end
end
function c511002200.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:UpdateAttack(500,RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
	end
end