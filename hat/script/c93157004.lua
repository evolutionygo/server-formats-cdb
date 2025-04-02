--ヴァイロン・オメガ
--Vylon Omega
function c93157004.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon Procedure
	aux.AddSynchroProcedure(c,nil,2,2,aux.NonTunerEx(Card.IsSetCard,SET_VYLON),1,1)
	--Destroy all Normal Summoned/Set monsters
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc93157004(c93157004,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(function(e) return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO) end)
	e1:SetTarget(c93157004.destg)
	e1:SetOperation(c93157004.desop)
	c:RegisterEffect(e1)
	--Equip 1 "Vylon" monster to itself
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc93157004(c93157004,1))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c93157004.eqtg)
	e2:SetOperation(c93157004.eqop)
	c:RegisterEffect(e2)
	aux.AddEREquipLimit(c,nil,c93157004.eqval,c93157004.equipop,e2)
	--Negate the activation of a monster's effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc93157004(c93157004,2))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c93157004.discon)
	e3:SetCost(c93157004.discost)
	e3:SetTarget(c93157004.distg)
	e3:SetOperation(c93157004.disop)
	c:RegisterEffect(e3)
	--Multiple tuners
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_MULTIPLE_TUNERS)
	c:RegisterEffect(e5)
end
c93157004.listed_series={SET_VYLON}
function c93157004.eqval(ec,c,tp)
	return ec:IsControler(tp) and ec:IsSetCard(SET_VYLON)
end
function c93157004.desfilter(c)
	return c:IsFaceup() and (c:GetSummonType()&SUMMON_TYPE_NORMAL)~=0
end
function c93157004.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c93157004.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c93157004.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c93157004.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c93157004.eqfilter(c)
	return c:IsSetCard(SET_VYLON) and c:IsMonster() and not c:IsForbc93157004den()
end
function c93157004.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c93157004.eqfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c93157004.eqfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c93157004.equipop(c,e,tp,tc)
	c:EquipByEffectAndLimitRegister(e,tp,tc,nil,true)
end
function c93157004.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		c93157004.equipop(c,e,tp,tc)
	end
end
function c93157004.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsMonsterEffect()
		and Duel.IsChainNegatable(ev)
end
function c93157004.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipGroup():IsExists(Card.IsAbleToGraveAsCost,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=e:GetHandler():GetEquipGroup():FilterSelect(tp,Card.IsAbleToGraveAsCost,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c93157004.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c93157004.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end