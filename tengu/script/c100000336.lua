--琰魔竜 レッド・デーモン (Manga)
--Hot Red Dragon Archfiend (Manga)
function c100000336.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	--Destroy all other Attack Position monsters
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc100000336(c100000336,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c100000336.target)
	e1:SetOperation(c100000336.operation)
	c:RegisterEffect(e1)
	--Cannot attack unless it destroys a monster this turn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetCondition(function(e) return e:GetHandler():GetFlagEffect(c100000336)==0 end)
	c:RegisterEffect(e2)	
end
function c100000336.filter(c)
	return c:IsAttackPos() and c:IsDestructable()
end
function c100000336.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000336.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(c100000336.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,#sg,0,0)
end
function c100000336.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000336.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		e:GetHandler():RegisterFlagEffect(c100000336,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END,0,1)
	end
end