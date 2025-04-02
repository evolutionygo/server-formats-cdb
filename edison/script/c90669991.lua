--パイナップル爆弾
--Pineapple Blast
function c90669991.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc90669991(c90669991,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c90669991.condition)
	e1:SetTarget(c90669991.target)
	e1:SetOperation(c90669991.activate)
	c:RegisterEffect(e1)
end
function c90669991.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
end
function c90669991.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,ct,0,0)
end
function c90669991.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-ct<=0 then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringc90669991(c90669991,1))
	local dg=g:Select(1-tp,ct,ct,nil)
	Duel.HintSelection(dg,true)
	Duel.Destroy(g-dg,REASON_EFFECT)
end