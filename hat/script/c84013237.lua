--No.39 希望皇ホープ
--Number 39: Utopia
function c84013237.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--Disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc84013237(c84013237,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetOperation(function() Duel.NegateAttack() end)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--Self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc84013237(c84013237,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c84013237.descon)
	e2:SetTarget(c84013237.destg)
	e2:SetOperation(c84013237.desop)
	c:RegisterEffect(e2)
end
c84013237.aux.xyz_number=39
function c84013237.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttackTarget()==c and c:GetOverlayCount()==0
end
function c84013237.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c84013237.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end